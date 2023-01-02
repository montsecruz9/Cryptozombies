pragma solidity >=0.5.0 <0.6.0;

// put import statement here
import "./zombiefactory";

// creating kitty interface
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

// inheritance 
contract ZombieFeeding is ZombieFactory {
    // Adding Cryptokitties contract address
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // Initializing kittyContract
    KittyInterface kittyContract = KittyInterface(ckAddress);
   
    // Creating function to feed and multiply zombies
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    // making sure we own this zombie 
    require(msg.sender == zombieToOwner[_zombieId]);
    // getting this zombie's dna
    Zombie storage myZombie = zombies[_zombieId];  
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // if statement to check if the zombie comes from a kitty and edit their dna
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }

    //Creating function that will interact with the CryptoKitties contract
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
    // declaring kittyDna (the 10th value)
    uint kittyDna;
    // Call the contract and store genes in kittyDna
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // call feedAndMultiply
    feedAndMultiply(_zombieId, kittyDna, "kitty"); 
  }

}
