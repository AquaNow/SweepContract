// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Sweep is Ownable {
    address private sweepAddress;

    constructor(address _sweepAddress) Ownable(msg.sender){
        sweepAddress = _sweepAddress;

    }

    function transferContractOwnership(address newOwner) external onlyOwner {
        transferOwnership(newOwner);
    }   

    function changeSweepAddress(address _sweepAddress) external onlyOwner {
        sweepAddress = _sweepAddress;
    }

    function getSweepAddress() external view returns (address) {
        return sweepAddress;
    }  

    

    function sweepTokens (address _tokenAddress, address[] memory recipients) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        for (uint256 i = 0; i < recipients.length; i++) {
            uint256 balance = token.balanceOf(recipients[i]);
            if (balance > 0) {
                require(token.transferFrom(recipients[i], sweepAddress, balance), "Transfer failed");
            }
        }
    }
}
