pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNft is ERC721, Ownable {

    using Strings for uint256;
    using Counters for Counters.Counter;

    string private _baseUri;
    string private _uriSuffix;

    Counters.Counter private _counter;

    constructor(string memory baseUri) ERC721("MyNft", "MNT") {
        _baseUri = baseUri;
        _uriSuffix = ".json";
    }

    function mint(address to) external onlyOwner {
        _counter.increment();
        _mint(to, _counter.current());
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "URI query for nonexistent token");

        string memory baseUri = _baseURI();
        return bytes(baseUri).length > 0
            ? string.concat(baseUri, tokenId.toString(), _uriSuffix) : ""; 
    } 

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseUri;
    }
}