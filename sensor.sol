pragma solidity ^0.4.18;

contract Sensor {
    string public name;
    uint public contentcounter;
    uint public gwcounter;
    
    address public admin;

    mapping (address => uint) public gateway;
    mapping (uint => address) public contentGW;
    mapping (uint => string) public content;
    
    
    constructor(string Name) public {
        name = Name;
        admin = msg.sender;
        gwcounter = 0;
        contentcounter = 0;
    }
    
    function addGateway(address _gwAdr) public {
        require(msg.sender == admin );
        gateway[_gwAdr] = 1;
    }
    
    function removeGateway(address _gwAdr) public {
        require(msg.sender == admin );
        gateway[_gwAdr] = 0;
    }
    
    function addContent(string newContent) public {
        require(gateway[msg.sender] == 1 );
        content[contentcounter] = newContent;
        contentGW[contentcounter] = msg.sender;
        contentcounter += 1;
    }
    
    function getContent(uint _msgId) public view returns (string){
        return content[_msgId];
    }
    
    function getContentGW(uint _msgId) public view returns (address){
        return contentGW[_msgId];
    }
}
