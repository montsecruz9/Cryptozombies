pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001 ether;

     modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
     _;
    }

    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }

    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns(uint[] memory) {

    }

    function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        //variable to keep track of the index in our result array
        uint counter = 0;
        // iterate over every zombie in our array
        for (uint i = 0; i < zombies.length; i++) {
            // compare the two addresses to see if we have a match
            if (zombieToOwner[i] == _owner) {
                // add the zombie's id to our result array
                result[counter] = i;
                // increment counter by 1
                counter++;
            }
        } 
        return result;
    }

}