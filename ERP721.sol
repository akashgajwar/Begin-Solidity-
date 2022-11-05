// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;


// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/IERC165.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Receiver.sol";


contract ERC721 { 
    event Transfer(address indexed from, address indexed to, uint256 indexed id);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id);
    event ApprovalForAll(address indexed owner, address operator, bool approved);

    mapping(uint => address) internal _ownerOf;                             // NFT --> address
    mapping(address => uint) internal _balanceOf;                           // fetch balance of address
    mapping(uint => address) internal _approvals;                           // check approval of single NFT
    mapping(address => mapping(address => bool)) public isApprovedForAll;   // check approval of NFT from walllet

    function ownerOf(uint id) external view returns(address){
        address owner = _ownerOf[id];
        require(owner != address(0), "token does not exist");
        return owner;
    }

    function balanceOf(address owner) external view returns(uint ){
        require(owner != address(0), "Address zero");
        return _balanceOf[owner];
    }

    function setApprovalForAll(address operator, bool approved)external{
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

     function approve(address spender, uint id)external {
        address owner = _ownerOf[id];
        require(msg.sender == owner || isApprovedForAll[owner][msg.sender], "not authorized");
        _approvals[id]= spender;

        emit Approval(owner, spender, id);
    }

    function getApproved(uint id)external view returns(address){
        require(_ownerOf[id] != address(0), "token does not exists");
        return _approvals[id];
    }

    function _isApprovedOwner(address owner, address spender, uint id) internal view returns(bool) {
        require(spender == owner || isApprovedForAll[owner][spender] || spender == _approvals[id]);
        return true;

    }

    function transferFrom(address from, address to, uint id) public{
        require(from == _ownerOf[id], "from is not the owner of id");
        require(to != address(0), "transfer to address zero");
        require(isApprovedForAll[from][msg.sender], "Not authorised");
        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;
        delete _approvals[id];

        emit Transfer(from, to, id);
    }
    

    function transfer(address to, uint id) public{
        require(_ownerOf[id] == msg.sender, "Can't transfer");
        _balanceOf[msg.sender]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;
        delete _approvals[id];

        emit Transfer(msg.sender, to, id); 
    }

    function _mint(address to, uint id) public {
        require(to != address(0), "mint to address zero");
        require(_ownerOf[id] == address(0), "already minted");

        _balanceOf[to]++;
        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
    }
}

contract MyNFT is ERC721{
    
    function minting(address to, uint id) external{
        _mint(to, id);
    
    }

    function TTransfer(address from, address to, uint id) external{
        transferFrom(from, to, id);
    }
    
}
