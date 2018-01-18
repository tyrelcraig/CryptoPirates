pragma solidity ^0.4.18;

import "./ShipPirates.sol";

contract ShipHelper is ShipPirates {

  modifier aboveLevel(uint8 _level, uint _shipId) {
    require(armada[_shipId].level >= _level);
    _;
  }

  function changeName(uint _shipId, string _newName) external aboveLevel(2, _shipId) {
    require(msg.sender == shipToOwner[_shipId]);
    armada[_shipId].name = _newName;
  }

  function changeBuild(uint _shipId, uint8 _shipBuild) external aboveLevel(20, _shipId) {
    require(msg.sender == shipToOwner[_shipId]);
    armada[_shipId].shipBuild = _shipBuild;
  }

  function getShipsByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerShipCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < armada.length; i++) {
      if (shipToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
