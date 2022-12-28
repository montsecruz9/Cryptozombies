pragma solidity >=0.5.0 <0.6.0;

// put import statement here
import "./zombiefactory";

// inheritance 
contract ZombieFeeding is ZombieFactory {

    // Creating function to feed and multiply zombies
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    // making sure we own this zombie 
    require(msg.sender == zombieToOwner[_zombieId]);
    // getting this zombie's dna
    Zombie storage myZombie = zombies[_zombieId];  

}
