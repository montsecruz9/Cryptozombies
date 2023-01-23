// version pragma
pragma solidity >=0.5.0 <0.6.0; 

import "./ownable.sol";

// Create contract
contract ZombieFactory is Ownable {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    // Creating event for app front-end
    event NewZombie(uint zombieId, string name, uint dna);

    // Create zombies
    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    // Create an army (array) of zombies
    Zombie[] public zombies;

    // Create mappings 
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function createZombie (string memory _name, uint _dna) internal {
        // adding zombies to array and declaring zombie's ids 
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        // assigning ownership to whoever called the function
        zombieToOwner[id] = msg.sender;
        // increase count for this msg.sender 
        ownerZombieCount[msg.sender]++;
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
        // making sure this function only gets executed one time per user
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}