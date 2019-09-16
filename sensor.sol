pragma solidity ^0.4.18;

contract Sensor {
    string public name;
    uint public contentcounter;
    uint public gwcounter;
    
    address public admin;

    mapping (address => uint) public gateway;
    mapping (uint => string) public content;
    
    
    constructor(string Name) public {
        name = Name;
        admin = msg.sender;
        gwcounter = 0;
        contentcounter = 0;
    }
    
    function reqGateway() public {
        require( !(msg.sender == admin) );
        require( ( gateway[msg.sender] < 1) );
        gateway[msg.sender] = 0;
    }
    
    function approveAdmin(address _newGateway) public {
        require(msg.sender == admin );
        require(gateway[msg.sender] < 1);
        gateway[_newGateway] = 1;
        gwcounter += 1;
    }
    
    function addContent(string newContent) public {
        require(gateway[msg.sender] == 1 );
        content[contentcounter] = newContent;
        contentcounter += 1;
    }
    
    function getContent(uint _msgId) public view returns (string){
        return content[_msgId];
    }
}
    
