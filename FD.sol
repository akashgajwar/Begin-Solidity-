// SPDX-License-Identifier: BUSL-1

pragma solidity =0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Bank is ERC20 {

    uint256 B_rate = 11;
    uint256 D_rate = 6 ;

   struct Data {
       uint256 amount;
       uint256 lastTime;
   }

    mapping (address => uint256) public userBalance;
    mapping (address => Data) public calc;

    function deposit(uint256 _amount) external {
        userBalance [msg.sender] = _amount;
        transferFrom( msg.sender, address(this), _amount);
    }

    function Lend(uint256 _amount) external {

    }
}
