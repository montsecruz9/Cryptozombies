pragma solidity >=0.5.0 <0.6.0;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

    // map to make sure only the owner or the approved address of a token/zombie can transfer it
    mapping (uint => address) zombieApprovals;

    // function to return the number of zombies _owner has
    function balanceOf(address _owner) external view returns (uint256) {
        return ownerZombieCount[_owner];
    }

    // function to return the address of whoever owns the zombie with ID _tokenId
    function ownerOf(uint256 _tokenId) external view returns (address) {
        return zombieToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        // increment ownerZombieCount for the person receiving the zombie
        ownerZombieCount[_to]++;
        // decrease ownerZombieCount for the person sending the zombie 
        ownerZombieCount[_from]--;
        // change zombieToOwner mapping from _tokenId to _to
        zombieToOwner[_tokenId] = _to;
        // fire Transfer event
        emit Transfer(_from, _to, _tokenId);
    }
    
    

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        // making sure only the owner or the approved address of a token/zombie can transfer it
        require (zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable {

    }

}
