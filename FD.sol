 // SPDX-License-Identifier: BUSL-1

pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Bank is ERC20 { 

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, 10000);
    } 
    // event SENDER(address);
    event credit(address indexed from, address indexed to, uint256 amount);
    event debit(address indexed from, address indexed to, uint256 amount);
    
    uint256 rate = 6 ; 

    mapping (address => Record) public Data;

    struct Record {
       uint256 amount;
       uint256 lastTime;
    }


// Deposit//- multiple deposit amount update how ? 

    function deposit(uint256 _amount) external {
        
        transfer( address(this), _amount);
        
        uint256 total = calc();
        uint256 superAmount = _amount + total;

        Data[msg.sender] = Record(superAmount, block.timestamp);

        emit credit(msg.sender, address(this), _amount);


    }        
 //withdraw// scale it for multiple people , person can withdraw any amout but it should be less than its deposit+interest, set amount, timestamp in struct after withdaral, 
//  add events in contract //

    function withdraw ( uint256 _amount) public {
        
        uint256 total = calc();
        require(total >= _amount, "can't withdraw more money you have in your account");
        
        uint256 balanceOfBank = balanceOf(address(this));

        if (balanceOfBank >= _amount){
            _transfer(address(this), msg.sender, _amount);
        }else{
            _mint(address(this), (_amount - balanceOfBank));
            _transfer(address(this), msg.sender, _amount);
        }
        
        Data[msg.sender].amount = total - _amount ;    
        Data[msg.sender].lastTime = block.timestamp;

        emit debit(address(this), msg.sender, _amount);

        
    }

// Interest calculation//  interest cal krke add kro amount mai  ?

    function calc() public view returns(uint256 _total){

        uint P = Data[msg.sender].amount;
        uint T= (block.timestamp - (Data[msg.sender].lastTime));
        
        uint SI = (P*T*rate)/100;
        uint total = P + SI;
        
        return total;

    }

}
