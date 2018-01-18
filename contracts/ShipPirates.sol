pragma solidity ^0.4.18;

import "./ShipYard.sol";

contract ShipPirates is ShipYard {

 function pirateNewShip(uint _shipId, uint _targetId) public {
     require(msg.sender == shipToOwner[_shipId]);
     Ship storage myShip = armada[_shipId];
     string memory myShipName = myShip.name;
     string memory number = uint2str(ownerShipCount[msg.sender]);
     string memory name = strConcat(myShipName, number);
     _createShip(name, _targetId, 1, false);
 }

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