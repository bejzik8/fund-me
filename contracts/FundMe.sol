// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract FundMe {
    // uint256 public number;

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD

        // number = 5;

        require(msg.value > 1e18, "Didn't send enough!"); // 1e18 == 1 * 10 ** 18 == 1.000.000.000.000.000.000

        // what is reverting?
        // undo any action before, and send the remaining gas back.
        // reverting => number is not set to 5.
    }

    // function withdraw() {}
}
