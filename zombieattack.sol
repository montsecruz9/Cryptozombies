pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    uint randNonce = 0;
    uint attackVistoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce = randNonce.add(1);
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
    } 
    
    function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
        // get a storage pointer to both zombies so we can easily interact with them
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        // get a random number between 0 and 99 to determine the battle outcome
        uint rand = randMod(100);
        if (rand <= attackVistoryProbability) {
            myZombie.winCount = myZombie.winCount.add(1);
            myZombie.level = myZombie.level.add(1);
            enemyZombie.lossCount = enemyZombie.lossCount.add(1);
            // run feedAndMultiply function
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.losscount = myZombie.losscount.add(1);
            enemyZombie.winCount = enemyZombie.winCount.add(1);
            // run _triggerCooldown function
            _triggerCooldown(myZombie);
        }
    }
}
