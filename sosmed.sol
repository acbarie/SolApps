pragma solidity ^0.4.18;

contract SosMed {
    string public name;
    string public picture;
    address public owner;
    struct Post{
        string content;
        string key; 
    }
    Post public latestpost;
    uint public friendnumber;
    uint256 public mypostcounter;
    uint256 public mfpostcounter;
    
    mapping (address => bool) public Friends;

    function addFriend(address _adr) public{
        require(msg.sender == owner);
        if (isFriend(_adr)==false){
            Friends[_adr]=true;
            friendnumber = friendnumber + 1;    
        }
    }
    
    function delFriend(address _adr) public{
        require(msg.sender == owner);
        if (isFriend(_adr)){
            Friends[_adr]=false;
            friendnumber = friendnumber - 1;
        }
    }
    
    event LogIt(address adr, string valuestr);
    
    function isFriend(address _adr) public view returns (bool){
        return Friends[_adr];
    }
    
    constructor(string memory _name, string memory _pict) public {
        require(bytes(_name).length > 0 && bytes(_name).length <= 32);
        require(bytes(_pict).length > 0 && bytes(_pict).length <= 32);
        name = _name;
        picture = _pict;
        owner = msg.sender;
        friendnumber = 0;
        latestpost.content = "Account creation.";
    }
    
    function newPost(string memory _post) public {
        require(bytes(_post).length > 0 && bytes(_post).length <= 256);
        require(msg.sender == owner);
        latestpost.content = _post;
        mypostcounter = mypostcounter +1;
        emit LogIt(msg.sender, latestpost.content);
        //return latestpost;
    }
    
    function friendPost(string memory _post, string memory _key) public {
        require(bytes(_post).length > 0 && bytes(_post).length <= 256);
        require(isFriend(msg.sender));
        latestpost.content = _post;
        latestpost.key = _key;
        mfpostcounter = mfpostcounter +1;
        emit LogIt(msg.sender, latestpost.content);
        //return latestpost;
    }
    
    
    
}
