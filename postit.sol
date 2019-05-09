pragma solidity ^0.4.18;

contract HelloWorld {
    string public name;
    string public picture;
    address public owner;
    string public latestpost;
    uint public numoffriend;
    
    //address of smart cotract, not user account address
    mapping (uint => address) friends;
    
    constructor(string Name, string Picture) public {
        name = Name;
        picture = Picture;
        owner = msg.sender;
        numoffriend = 0;
        latestpost = "Account created.";
    }
    
    function newPost(string _post) public returns (string){
        require(msg.sender == owner);
        latestpost = _post;
        return latestpost;
    }
    
    function getLatestPost() public constant returns (string){
        return latestpost;
    }
    
    function addFriend(address _adr) public {
        require(msg.sender == owner);
        friends[numoffriend] = _adr;
        numoffriend = numoffriend+1;
    }
    
    function getFriend(uint _number) public constant returns (address){
        return friends[_number];
    }
}