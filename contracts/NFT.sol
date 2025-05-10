// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin's ERC721 implementations
import { ERC721URIStorage, ERC721 } from '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import { ERC721Enumerable } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/// @title NFT Contract
/// @notice A simple NFT contract that allows minting of tokens with metadata
/// @dev Extends OpenZeppelin's ERC721URIStorage for URI storage functionality
/// @dev Implements ERC721Enumerable for enumeration capabilities
contract NFT is ERC721, ERC721Enumerable, ERC721URIStorage {
    // Counter for token IDs, automatically initialized to 0
    // This ensures each token has a unique ID
    uint256 private _nextTokenId;

    /// @notice Initialize the NFT contract
    /// @dev Sets the name "NFT" and symbol "NFT" for the collection
    /// @dev Inherits from multiple ERC721 implementations
    constructor() ERC721('NFT', 'NFT') {}

    /// @notice Mint a new NFT to a specified address with metadata
    /// @dev Mints token and sets its URI in one transaction
    /// @dev Uses auto-incrementing token IDs for uniqueness
    /// @param user The address that will receive the minted NFT
    /// @param tokenURI The metadata URI for the NFT (typically points to IPFS or HTTP URL)
    /// @return uint256 The ID of the newly minted token
    function createNft(address user, string memory tokenURI) public returns (uint256) {
        uint256 tokenId = _nextTokenId++; // Get current token ID and increment
        _mint(user, tokenId); // Mint the NFT to the user
        _setTokenURI(tokenId, tokenURI); // Set the token's metadata URI

        return tokenId;
    }

    /// @notice Internal function to increase the balance of an account
    /// @dev Required override due to multiple inheritance
    /// @param account The address whose balance will be increased
    /// @param amount The amount to increase the balance by
    function _increaseBalance(address account, uint128 amount) 
        internal  
        override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, amount);
    }

    /// @notice Internal function to update token ownership
    /// @dev Required override due to multiple inheritance
    /// @param to The address receiving the token
    /// @param tokenId The ID of the token being transferred
    /// @param auth The address authorized to make the transfer
    /// @return address The previous owner of the token
    function _update(address to, uint256 tokenId, address auth) 
        internal 
        override(ERC721, ERC721Enumerable)
        returns (address) {
            return super._update(to, tokenId, auth);
    }

    /// @notice Check if the contract supports a specific interface
    /// @dev Required override due to multiple inheritance
    /// @param interfaceId The interface identifier to check
    /// @return bool True if the interface is supported, false otherwise
    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        override(ERC721, ERC721Enumerable, ERC721URIStorage) 
        returns (bool) {
            return super.supportsInterface(interfaceId);
    }

    /// @notice Get the URI for a specific token
    /// @dev Required override due to multiple inheritance
    /// @param tokenId The ID of the token to get the URI for
    /// @return string The URI string containing the token's metadata
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
