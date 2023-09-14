
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract MyNFTVRF is ERC721Enumerable, VRFConsumerBase, Ownable {
    
    bytes32 internal keyHash;
    uint256 internal fee;


    struct Traits {
        uint256 strenght;
        uint256 speed;
        uint256 power;
        uint256 tall;
        uint256 strong;
        uint256 armor;
    }


    mapping(uint256 => Traits) public tokenIdToTraits;

    constructor(
        address _vrfCoordinator,
        address _linkToken,
        bytes32 _keyHash,
        uint256 _fee
    )
        ERC721("DYPUMPING", "NFT")
        VRFConsumerBase(_vrfCoordinator, _linkToken)
    {
        keyHash = _keyHash;
        fee = _fee;
    }

    
    function mint() external {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK");
        require(LINK.transferAndCall(address(this), fee, bytes("")), "LINK transfer failed");
    }

    
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        uint256 tokenId = totalSupply() + 1;
        uint256 energy = randomness % 101;
        uint256 speed = (randomness >> 8) % 101;

        Traits memory newTraits = Traits(energy, speed, 0, 0, 0, 0);
        tokenIdToTraits[tokenId] = newTraits;

        _mint(msg.sender, tokenId);
    }
}