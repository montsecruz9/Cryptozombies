// version pragma
pragma solidity >=0.5.0 <0.6.0; 

// Create contract
contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Create zombies
    struct Zombie {
        string name;
        uint dna;
    }

    // Create an army (array) of zombies
    Zombie[] public zombies;

    function createZombie (string memory _name, uint _dna) public {
        // add zombies to the array
        zombies.push(Zombie(_name, _dna));
    }
}