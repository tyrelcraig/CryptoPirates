pragma solidity ^0.4.18;

import "./ShipYard.sol";

contract ShipPirates is ShipYard {

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

//Take in a stray Kitty. If ready Gain a ship with a shield.
/* 
Commenting out this function for the moment. Seems to be a break/error with the multiple return values.
Could be something to do with the Truffle Parser.

function strayKitty(uint _shipId, uint _kittyId) public {
     bool ready;
     (,ready,,,,,,,,) = kittyContract.getKitty(_kittyId);
     require(msg.sender == shipToOwner[_shipId]);
     Ship storage myShip = armada[_shipId];

 }
*/

// Take over a new ship and add it to your armada. 
 function pirateNewShip(uint _shipId, uint _targetId) public {
     require(msg.sender == shipToOwner[_shipId]);
     Ship storage myShip = armada[_shipId];
     string memory myShipName = myShip.name;
     string memory number = uint2str(ownerShipCount[msg.sender]);
     string memory name = strConcat(myShipName, number);
     _createShip(name, _targetId, 1, false);
 }
 
 // Helper Function: Convert Unsigned Integer to String. Return a String.
 function uint2str(uint num) internal pure returns (string) {
    if (num == 0) {
         return "0";
    }
    
    uint j = num;
    uint len;

    while (j != 0) {
        len++;
        j /= 10;
    }

    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (num != 0) {
        bstr[k--] = byte(48 + num % 10);
        num /= 10;
    }
    return string(bstr);
}

 //Helper Function: Concatenate two strings. Return a String
 function strConcat(string _name, string _count) internal pure returns (string) {
     bytes memory _nameBytes = bytes(_name);
     bytes memory _countBytes = bytes(_count);

     string memory resultLength = new string(_nameBytes.length + _countBytes.length);
     bytes memory resultBytes = bytes(resultLength);

    uint k = 0;
    for (uint i = 0; i < _nameBytes.length; i++) {
        resultBytes[k++] = _nameBytes[i];
    }
    for (i = 0; i < _countBytes.length; i++) {
        resultBytes[k++] = _countBytes[i];
    }
    return string(resultBytes);
 }

}

 // Pulling in and working with CryptoKitties Interface.
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