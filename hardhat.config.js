require("@nomicfoundation/hardhat-toolbox");

const SEPOLIA_PRIVATE_KEY = "";
const ALCHEMY_API_KEY = "";
const ETHERSCAN_API_KEY = "";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
  },

  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};
