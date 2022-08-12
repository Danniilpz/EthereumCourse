//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

//Simple Bank

contract Banco{
    constructor() payable {
    }
    function incrementBalance(uint256 amount) payable public {
        require(msg.value == amount);
    }
    function getBalance() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}