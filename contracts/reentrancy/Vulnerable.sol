// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Vulnerable {
    // INSECURE
    mapping (address => bool) private seenUsers;

    receive() payable external {}

    // uint256 value;

    constructor() payable {
        //value = _p;
    }

    // function setP(uint256 _n) payable public {
    //     value = _n;
    // }

    function giveOneEth() public payable{
        require(!seenUsers[msg.sender], "This user has already receive a free ether");
        (bool success, bytes memory data) = msg.sender.call(abi.encodeWithSignature("doesNotExist()")); // At this point, the caller's code is executed, and can call withdrawBalance again
        //require(success, "the call was not successfull");
        seenUsers[msg.sender] = true;
    }
}
