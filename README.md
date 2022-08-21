# Begin-Solidity-
Let's start

// SPDX-License-Identifier: BUSL-1

pragma solidity =0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(uint256 amount) external {
        _mint(msg.sender, amount);
    }
}

contract Bank {
    IERC20 public token;
    mapping(address => uint256) public userBalance;

    constructor(IERC20 _token) {
        token = _token;
    }

    function deposit(uint256 _amount) external {
        userBalance[msg.sender] = _amount;
        token.transferFrom(msg.sender, address(this), _amount);
    }
}

