pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";

contract ShipYard is Ownable {
    
    event NewShip (
        uint shipId, 
        string name,
        uint shipBuild,
        uint shipLife,
        bool shipShield
        );

    uint shipDigits = 16;
    uint shipModulus = 10 ** shipDigits;
    uint lifeModulus = 5;

    struct Ship {
        string name;
        uint shipBuild;
        uint shipLife;
        bool shipShield;
    }

    Ship[] public armada;

    mapping (uint => address) public shipToOwner;
    mapping (address => uint) ownerShipCount;


    function _createShip(string _name, uint _shipBuild, uint _shipLife, bool _shipShield) private {
        uint id = armada.push(Ship(_name, _shipBuild, _shipLife, _shipShield)) - 1;
        shipToOwner[id] = msg.sender;
        ownerShipCount[msg.sender]++;
        NewShip (id, _name, _shipBuild, _shipLife, _shipShield);
    }

    function _generateRandomShipBuild(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % shipModulus;
    }

    function _generateRandomLife(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % lifeModulus;
    }

    function createRandomShip(string _name) public {
        require(ownerShipCount[msg.sender] == 0);
        uint randShipBuild = _generateRandomShipBuild(_name);
        uint _shipLife = _generateRandomLife(_name);
        _createShip(_name, randShipBuild, _shipLife, false);
    }
}

