// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Joint Savings Account Contract
contract JointSavings {

    // Contract variables
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;

    uint public lastWithdrawAmount;
    uint public contractBalance;


    function withdraw(uint amount, address payable  recipient ) public {
        // recipient has to be one of accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // contract balance has to be enough for the transfer
        require(amount < contractBalance, "Insufficient funds!");

        // update last to withdraw variable
        if(lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // transfer the funds
        recipient.transfer(amount);

        // update last withdrawn amount variable
        lastWithdrawAmount = amount;

        // update contract balance variable
        contractBalance = address(this).balance;

    }

    function deosit() public payable {
        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    fallback() external {}
}