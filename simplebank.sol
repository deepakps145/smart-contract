// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // Deposit Ether into the bank
    function deposit() public payable {
        require(msg.value > 0, "Deposit must be > 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the bank
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    // Transfer balance inside the bank to another user
    function transfer(address to, uint256 amount) public {
        require(to != address(0), "Invalid recipient");
        require(amount > 0, "Transfer must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    // View your balance stored in the bank
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}