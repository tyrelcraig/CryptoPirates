pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";

contract ShipYard is Ownable {
    
    event NewShip (
        uint shipId, 
        string name,
        uint8 shipBuild,
        uint8 shipLife,
        bool shipShield
        );

    uint shipDigits = 16;
    uint shipModulus = 10 ** shipDigits;
    uint lifeModulus = 5;

    struct Ship {
        string name;
        uint8 shipBuild;
        uint8 shipLife;
        bool shipShield;
    }

    Ship[] public armada;

    mapping (uint => address) public shipToOwner;
    mapping (address => uint) ownerShipCount;


    function _createShip(string _name, uint8 _shipBuild, uint8 _shipLife, bool _shipShield) internal {
        uint id = armada.push(Ship(_name, _shipBuild, _shipLife, _shipShield)) - 1;
        shipToOwner[id] = msg.sender;
        ownerShipCount[msg.sender]++;
        NewShip (id, _name, _shipBuild, _shipLife, _shipShield);
    }

    function _generateRandomShipBuild(string _str) private view returns (uint8) {
        uint rand = uint8(keccak256(_str));
        return uint8(rand % shipModulus);
    }

    function _generateRandomLife(string _str) private view returns (uint8) {
        uint rand = uint(keccak256(_str));
        return uint8(rand % lifeModulus);
    }

    function createRandomShip(string _name) public {
        require(ownerShipCount[msg.sender] == 0);
        uint8 randShipBuild = _generateRandomShipBuild(_name);
        uint8 _shipLife = _generateRandomLife(_name);
        _createShip(_name, randShipBuild, _shipLife, false);
    }
}

