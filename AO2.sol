// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Publish is ERC721URIStorage {

    uint256 private _tokenID;

    //functions can be called on fic and ARC is the symbol name
    constructor() ERC721("Fic", "ARC") {}

function mint(address author, string memory uri) public returns (uint256) {
    uint256 token = _tokenID++;
    _mint(author, token);
    _setTokenURI (token, uri);
    
    return token;
}

}
contract Sales {
mapping(address => bool) public HighTrust;

modifier onlyHighTrust() {
    require(HighTrust[msg.sender], "Only a publisher or an archivist can execute this");
    _;

}
}
