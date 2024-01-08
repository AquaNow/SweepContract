// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hardhat = require("hardhat");

async function main() {
  const SweepContract = await ethers.getContractFactory("Sweep");
  console.log("Deploying MyContract...");
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // Deploy the contract
  const sweepContract = await SweepContract.deploy(
    "0x7FBCF12dCFA4a5597b4e95c634408FdBD45161d3"
  );

  console.log("SweepContract deployed to:", sweepContract.address);
  console.log("sweepAddress:", "0x7FBCF12dCFA4a5597b4e95c634408FdBD45161d3");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
