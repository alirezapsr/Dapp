// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract Coin {
    
	// minter()
    address public minter;
	
    mapping (address => uint) public balances;
    event Sent(address addFrom, address addTo, uint amount);
    
    constructor() public {
        minter = msg.sender;
    }
    
    modifier onlyMinter() {
        require(msg.sender == minter, "Only Minter can Mint!");
        _;
    }
    
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Balance don't enough!");
        _;
    }
    
    function mint(address receiver, uint amount) public onlyMinter {
        balances[receiver] += amount;
    }
    
    function transfer(address receiver, uint amount) public hasEnoughBalance(amount) {
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}