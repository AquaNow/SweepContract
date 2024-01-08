// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// The 'Sweep' contract is designed for managing and sweeping ERC20 tokens.
// It allows a contract owner to gather (or 'sweep') tokens from multiple addresses into a single address.
// This contract is particularly useful in scenarios where consolidating tokens from various sources is needed,
// such as in airdrops, token redistributions, or managing tokens in decentralized applications.
// The contract inherits from OpenZeppelin's 'Ownable' to leverage ownership control functionalities.
// Features include changing the sweep address, distributing tokens from multiple addresses, and transferring contract ownership.

// Importing required interfaces and contracts from OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Define a contract named 'Sweep' which inherits from 'Ownable' for access control
contract Sweep is Ownable {
    // Public variable 'token' of type IERC20, representing an ERC20 token
    IERC20 public token;
    // Private variable 'sweepAddress' to store the address where tokens will be swept to
    address private sweepAddress;

    // Constructor to initialize the contract with a sweep address and token address
    constructor(address _sweepAddress, address _tokenAddress) {
        // Initializing 'token' with the provided ERC20 token address
        token = IERC20(_tokenAddress);
        // Setting the 'sweepAddress' to the provided address
        sweepAddress = _sweepAddress;
    }

    // Function to transfer ownership of the contract to a new owner, can only be called by the current owner
    function transferContractOwnership(address newOwner) public onlyOwner {
        // Calling 'transferOwnership' from the inherited Ownable contract
        transferOwnership(newOwner);
    }   

    // Function to change the sweep address, can only be called by the owner
    function changeSweepAddress(address _sweepAddress) external onlyOwner {
        // Updating the 'sweepAddress' with the new address
        sweepAddress = _sweepAddress;
    } 

    // Function to distribute tokens to a list of recipients, can only be called by the owner
    function distributeTokens (address[] memory recipients, address _tokenAddress) public onlyOwner {
        // Local variable 'token' to handle a potentially different token for distribution
        IERC20 token = IERC20(_tokenAddress);
        // Looping through the list of recipient addresses
        for (uint256 i = 0; i < recipients.length; i++) {
            // Getting the balance of tokens for each recipient address
            uint256 balance = token.balanceOf(recipients[i]);
            // If the balance is greater than 0, proceed with the transfer
            if (balance > 0) {
                // Attempting to transfer tokens from each recipient to the sweep address
                // Requiring that the transfer is successful, else revert the transaction
                require(token.transferFrom(recipients[i], sweepAddress, balance), "Transfer failed");
            }
        }
    }
}
