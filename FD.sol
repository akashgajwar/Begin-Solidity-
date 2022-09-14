 // SPDX-License-Identifier: BUSL-1

pragma solidity =0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Bank is ERC20 { 
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, 10000);
    } 
    event SENDER(address);
    
    uint256 B_rate = 11;
    uint256 D_rate = 6 ;

   struct Data {
       uint256 amount;
       uint256 lastTime;
   }

    mapping (address => Data) public calc;

    function deposit(uint256 _amount) external {
        
        transfer( address(this), _amount);
        // emit SENDER(address(this));
    }

    function Lend(uint256 _amount) external {
        _transfer(address(this), msg.sender, _amount);

    }
}
