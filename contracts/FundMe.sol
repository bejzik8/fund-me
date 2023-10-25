// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    // uint256 public number;

    uint256 public minimumUsd = 50 * 1e18; // 1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD

        // number = 5;

        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!"); // 1e18 == 1 * 10 ** 18 == 1.000.000.000.000.000.000

        // what is reverting?
        // undo any action before, and send the remaining gas back.
        // reverting => number is not set to 5.

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        // for loop
        // [1, 2, 3, 4]
        //  0  1  2  3 - indexes

        /* starting index, ending index, step amount */ 
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            // code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array

        funders = new address[](0);

        // withdraw the funds

        // 1.) transfer

        // typeof msg.sender = address
        // typeof payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);

        // 2.) send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed!");

        // 3.) call
        (bool callSuccess, ) = payable(msg.sender).call{ value: address(this).balance }("");
        require(callSuccess, "Call failed!");
    }
}
