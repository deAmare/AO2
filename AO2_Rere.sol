// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Publish is ERC721URIStorage {

    uint256 private _tokenID;

    //functions can be called on fic and ARC is the symbol name
    constructor() ERC721("Fic", "ARC") {

    }
    
    // text data struct
    struct TextData {
        address publisher;     // NFT owner / original publisher
        string title;          // title of the archive text
        string content;        // short text stored on-chain
        address owner;         // owner
    }

    // tokenId => text data
    mapping(uint256 => TextData) public texts;

    // list of all token IDs
    uint256[] public publishedTexts;

    event TextPublished(
        uint256 indexed tokenId,
        address indexed publisher,
        string title
    );

    // publish function
    function publish(

        string memory title,
        string memory content

    ) public returns (uint256) {

        // optional text limit
        require(
            bytes(content).length <= 500,
            "Text too long"
        );
        uint256 token = _tokenID++;

        // mint NFT to publisher
        _mint(msg.sender, token);


        // create text object
        texts[token] = TextData({
            publisher: msg.sender,
            title: title,
            content: content,
            owner: msg.sender
        });

        // add tokenId to list
        publishedTexts.push(token);

        emit TextPublished(
            token,
            msg.sender,
            title
        );

        return token;
    }

    // retrieve text based on the token
    // problem is, i dont. know the text's token.
    // okay update i do know the token, just that
    // it heavily depends on u remembering the output
    // from the uh when u published the work

    function getText(
        uint256 tokenId
    ) public view returns (TextData memory) {

        return texts[tokenId];
    }

    function getAllPublishedTexts()
        public
        view
        returns (uint256[] memory)
    {
        // returns array of tokens?
        return publishedTexts;
    }

    // i didnt touch this
    function mint(address author, string memory uri) public returns (uint256) {
    uint256 token = _tokenID++;
    _mint(author, token);
    _setTokenURI (token, uri);
    
    return token;
}
}




// i didnt touch this
contract Sales {
mapping(address => bool) public HighTrust;

modifier onlyHighTrust() {
    require(HighTrust[msg.sender], "Only a publisher or an archivist can execute this");
    _;

}
}
