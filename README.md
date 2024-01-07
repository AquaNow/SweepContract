# Sweep Smart Contract

## Overview
The Sweep smart contract is a powerful tool for managing and distributing ERC20 tokens. It allows for the secure transfer of tokens from multiple addresses to a designated sweep address. Built with Solidity, this contract leverages OpenZeppelin's IERC20 and Ownable contracts to ensure security and ownership management.

## Features
- **ERC20 Token Interaction**: The contract uses the OpenZeppelin's IERC20 interface for ERC20 token management.
- **Ownership Management**: Built on OpenZeppelin's Ownable contract, it restricts critical functions to the contract owner.
- **Flexible Sweep Address**: The contract owner can dynamically change the sweep address.

## Functions

### Constructor
```solidity
constructor(address _sweepAddress)
```
Initializes the contract with the specified sweep address.

### transferContractOwnership
```solidity
function transferContractOwnership(address newOwner) public onlyOwner
```
Allows the owner to transfer the contract's ownership.

### changeSweepAddress
```solidity
function changeSweepAddress(address _sweepAddress) external onlyOwner
```
Permits the owner to update the sweep address.

### distributeTokens
```solidity
function distributeTokens(address[] memory recipients, address _tokenAddress) public onlyOwner
```
Facilitates the distribution of tokens from multiple addresses to the sweep address. Restricted to the contract owner.

## Development Setup

### Prerequisites
- Node.js and npm (Node Package Manager)
- Hardhat - Ethereum development environment

### Setting Up the Environment
1. **Install Node.js and npm**: Visit [Node.js](https://nodejs.org/) to download and install.
2. **Install Hardhat**: Run `npm install --save-dev hardhat`.
3. **Clone the Repository**: `git clone https://github.com/AquaNow/SweepContract.git`.
4. **Install Dependencies**: Navigate to the cloned directory and run `npm install`.

### Compiling and Testing
- Compile the contract: `npx hardhat compile`.
- Run tests: `npx hardhat test`.

## Deployment

To deploy the Sweep Smart Contract, follow these steps using Hardhat, a popular Ethereum development environment. The provided script allows for easy deployment of the contract.

### Prerequisites
- Ensure that you have Node.js, npm, and Hardhat installed. If not, refer to the Development Setup section above for installation instructions.

### Deployment Script
The deployment script is written in JavaScript and uses Hardhat's environment. Below is an explanation of the key parts of the script:

1. **Hardhat Runtime Environment**: The script explicitly requires the Hardhat Runtime Environment. This allows it to be run both as a standalone script using `node <script>` and through Hardhat using `npx hardhat run <script>`.

2. **Contract Deployment**: The script deploys the `Sweep` smart contract. It logs the deployment process and confirms once the contract is successfully deployed, along with the contract's address on the blockchain.

### Deploying the Contract
1. **Navigate to your project directory** where the deployment script is located.

2. **Run the deployment script**:
   ```shell
   npx hardhat run scripts/deploy.js
   ```

   This command will compile your contracts (if they haven't been compiled already), run the deployment script, and output the address where your contract was deployed.

### Error Handling
The script includes an error handling mechanism. If an error occurs during deployment, it will be logged to the console, and the process will exit with a non-zero exit code.

### Script
```javascript
const hardhat = require("hardhat");

async function main() {
  const SweepContract = await ethers.getContractFactory("Sweep");
  console.log("Deploying SweepContract...");

  const sweepContract = await SweepContract.deploy();
  await sweepContract.deployed();
  console.log("SweepContract deployed to:", sweepContract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

**Note**: Make sure to replace the `scripts/deploy.js` path with the actual path of your deployment script if it's different.

## Disclaimer
The Sweep Smart Contract is developed and provided as-is, without warranties. The users of this contract assume all risks associated with its use, including but not limited to the risk of financial loss. We are not responsible for any lost, stolen, or otherwise compromised assets. The security and management of private keys and digital assets are entirely the user's responsibility. This smart contract does not hold or store assets at any time and is strictly designed for utility purposes. Users should perform their due diligence and consider seeking professional advice before interacting with this contract or any smart contract.

## License
MIT License Copyright (c) 2024 Aquanow

---
