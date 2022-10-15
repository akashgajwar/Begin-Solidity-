// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./IERC721.sol";
import "./IERC165.sol";
import "./IERC721Receiver.sol";

contract ERC721 is IERC721{
    event Transfer(address indexed from, address indexed to, uint256 indexed id);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id);
    event ApprovalForAll(address indexed owner, address operator, bool approved);

    mapping(uint => address) internal _ownerOf;                             // NFT --> address
    mapping(address => uint) internal _balanceOf;                           // fetch balance of address
    mapping(uint => address) internal _approvals;                           // check approval of single NFT
    mapping(address => mapping(address => bool)) public isApprovedForAll;   // check approval of NFT from walllet

    function ownerOf(uint id) external vew returns(address owner){
        owner = _ownerOf[id];
        require(owner != address(0), "token does not exist");
        return owner;
    }

    function balanceOf(address owner) external view returns(uint ){
        require(owner != address(0), "Address zero");
        return
    }
}
