// version pragma
pragma solidity >=0.5.0 <0.6.0; 

// Create contract
contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Creating event for app front-end
    event NewZombie(uint zombieId, string name, uint dna);

    // Create zombies
    struct Zombie {
        string name;
        uint dna;
    }

    // Create an army (array) of zombies
    Zombie[] public zombies;

    function createZombie (string memory _name, uint _dna) public {
        // adding zombies to array and declaring zombie's ids 
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // declaring event
        emit NewZombie(id, _name, _dna);
    }

    // generating random dna for zombies
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str));
        return rand % dnaModulus; //our dna will only be 16 digits long
    }

    // randomly creating zombies 
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}