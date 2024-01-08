const {expect} = require("chai");

describe("Sweep", function () {
  async function deployMockERC20() {
    const [owner, , , user1, user2, user3] = await ethers.getSigners();

    const MockToken = await ethers.getContractFactory("MockToken");
    const token = await MockToken.deploy("MockToken", "MCK");
    return {token, owner, user1, user2, user3};
  }
  async function deploySweepContract() {
    const [owner, sweepAddress, newOwner] = await ethers.getSigners();
    const Sweep = await ethers.getContractFactory("Sweep");
    const sweep = await Sweep.deploy(sweepAddress.address);

    return {sweep, owner, sweepAddress, newOwner};
  }

  describe("Deployment", async function () {
    it("Should properly initialize contract", async function () {
      const {sweep, owner, sweepAddress} = await deploySweepContract();
      expect(await sweep.owner()).to.equal(owner.address);
      expect(await sweep.getSweepAddress()).to.equal(sweepAddress.address);
    });

    it("Should properly transfer ownership", async function () {
      const {sweep, owner, newOwner} = await deploySweepContract();
      expect(await sweep.owner()).to.equal(owner.address);
      await sweep.transferOwnership(newOwner.address);
      expect(await sweep.owner()).to.equal(newOwner.address);
      await expect(
        sweep.transferOwnership(newOwner.address)
      ).to.be.revertedWithCustomError(sweep, "OwnableUnauthorizedAccount");
    });

    it("Should properly change sweep address", async function () {
      const {sweep, newOwner, sweepAddress} = await deploySweepContract();
      expect(await sweep.getSweepAddress()).to.equal(sweepAddress.address);
      await sweep.changeSweepAddress(newOwner.address);
      expect(await sweep.getSweepAddress()).to.equal(newOwner.address);
    });
  });

  describe("ERC20 Sweeping", function () {
    it("Should sweep tokens from given addresses", async function () {
      const {token, owner, user1, user2, user3} = await deployMockERC20();
      const {sweep, sweepAddress} = await deploySweepContract();

      expect(await token.balanceOf(user1.address)).to.equal(0);
      expect(await token.balanceOf(user2.address)).to.equal(0);
      expect(await token.balanceOf(user3.address)).to.equal(0);

      await token.transfer(user1.address, 100);
      await token.transfer(user2.address, 100);
      await token.transfer(user3.address, 100);

      expect(await token.balanceOf(user1.address)).to.equal(100);
      expect(await token.balanceOf(user2.address)).to.equal(100);
      expect(await token.balanceOf(user3.address)).to.equal(100);

      await token.connect(user1).approve(sweep.target, 100);
      await token.connect(user2).approve(sweep.target, 100);
      await token.connect(user3).approve(sweep.target, 100);

      await sweep.sweepTokens(token.target, [
        user1.address,
        user2.address,
        user3.address,
      ]);
      expect(await token.balanceOf(user1.address)).to.equal(0);
      expect(await token.balanceOf(user2.address)).to.equal(0);
      expect(await token.balanceOf(user3.address)).to.equal(0);
    });
  });
});
