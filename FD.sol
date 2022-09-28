 // SPDX-License-Identifier: BUSL-1

pragma solidity =0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Bank is ERC20 { 

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, 10000);
    } 
    event SENDER(address);
    
    uint256 rate = 6 ; 

    mapping (address => Record) public Data;

    struct Record {
       uint256 amount;
       uint256 lastTime;
    }
// Deposit//

    function deposit(uint256 _amount) external {
        
        transfer( address(this), _amount);

        Data[msg.sender] = Record(_amount, block.timestamp);

    }      

 //withdraw// scale it for multiple people , person can withdraw any amout but it should be less than its deposit+interest, set amount, timestamp in struct after withdaral, 
//  add events in contract //

    function withdraw () public returns(uint256) {
        
        uint256 total = calc();
        uint256 balanceOfBank = balanceOf(address(this));

        if (balanceOfBank >=total){
            _transfer(address(this), msg.sender, total);
        }else{
            _mint(msg.sender, total - balanceOfBank);
            _transfer(address(this), msg.sender, balanceOfBank);
        }
        
        
        Data[msg.sender].amount = 0;    

        return total;
    }

// Interest calculation//

    function  calc() public view returns(uint _total){

        uint P = Data[msg.sender].amount;
        uint T= (block.timestamp - (Data[msg.sender].lastTime)/1 seconds);
        
        uint SI = (P*T*rate)/100;

        uint total = P + SI;

        return total;

    }
}
