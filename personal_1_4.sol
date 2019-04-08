pragma solidity ^0.4.22;

// single copy mode
contract PersonalPage2 {
    
    struct bioData{
        string Name;
        address Adr;
        uint256 HashID; //Hash(actualnama, ID Card number, Adr)
        string Url;
        string Phone;
        string Email;
        string PubKey;
    }
    
    bioData public Owner;

    struct Post{
        string message;    
        uint creationTime;
        string hash;
    }
    Post public Latest_Post;
    Post public Recent_Post;
    
    struct Message{
        string message;
        string password; 
        uint creationTime;
    }
    mapping (address  => Message) public Latest_Message;
    mapping (address  => Message) public Latest_PM;
    
    struct Comment{
        string transaction;
        string comment;    
        uint time;
    }
    Comment public latest_Comment;
    
    mapping (uint => Post) mystatus;
    mapping (address => string) certifier;
    mapping (address => string) certificate;
    string currentCertifier;
    uint latest;
    uint index;
    
    constructor(string Name, uint256 HashID, string Url, string Phone, string Email) public {
        require(bytes(Name).length > 0 && bytes(Name).length <= 64);
        require(bytes(Url).length > 0 && bytes(Url).length <= 100);
        require(bytes(Phone).length > 0 && bytes(Phone).length <= 32);
        require(bytes(Email).length > 0 && bytes(Email).length <= 64);
        require(HashID!=0);
        
        Owner.Adr = msg.sender;
        Owner.Name = Name;
        Owner.HashID = HashID;
        Owner.Url = Url;
        Owner.Phone = Phone;
        Owner.Email = Email;
        currentCertifier = "";
        latest = 0;
        index = 0;
        post("Account is created.","");
    }
    
    function post(string userstatus, string hashvalue) public {
        require(bytes(userstatus).length > 0 && bytes(userstatus).length <= 256);
        require(msg.sender == Owner.Adr);
        latest = latest +1;
        if (latest > 10){//reset latest
            latest = 1;
        }
        mystatus[latest].message = userstatus;
        mystatus[latest].creationTime = now;
        mystatus[latest].hash = hashvalue;
        //Latest_Post.message = mystatus[latest].data.message;
        //Latest_Post.creationTime = mystatus[latest].data.creationTime;
        Latest_Post = mystatus[latest];
        Recent_Post = mystatus[latest];
    }
    
    function revokeKey(string Public_key) public {
        require(bytes(Public_key).length > 0 && bytes(Public_key).length <= 256);
        require(msg.sender == Owner.Adr);
        Owner.PubKey = Public_key;
    }
    
    function getCertificate(address certifierAdr) public view returns (string) {
        return certificate[certifierAdr];
    }
    
    function getLatestStatus(uint idStatus) public returns (string) {
        index = latest;
        if (idStatus > 0){
            index = idStatus;
            Recent_Post = mystatus[index];
            return Recent_Post.message;
        }else{
            Latest_Post = mystatus[index];
            return Latest_Post.message;
        }
    }
    
    function commentOn(string Transaction_Hash, string comment) public {
        require(bytes(Transaction_Hash).length > 0 && bytes(Transaction_Hash).length <= 100);
        require(bytes(comment).length > 0 && bytes(comment).length <= 256);
        require(msg.sender == Owner.Adr);
        latest_Comment.transaction = Transaction_Hash;
        latest_Comment.comment = comment;
        latest_Comment.time = now;
    }
    
    function publicMessage(string comment) public {
        require(bytes(comment).length > 0 && bytes(comment).length <= 256);
        require(msg.sender != Owner.Adr);
        Latest_Message[msg.sender].message = comment;
        Latest_Message[msg.sender].creationTime = now;
        Latest_Message[msg.sender].password = "";
    }
    
    function privateMessage(string comment, string password) public {
        require(bytes(comment).length > 0 && bytes(comment).length <= 256);
        require(msg.sender != Owner.Adr);
        Latest_PM[msg.sender].message = comment;
        Latest_PM[msg.sender].creationTime = now;
        Latest_PM[msg.sender].password = password;
    }
    
    function addCertifier(address certifierAdr, string name) public {
        require(bytes(name).length > 5 && bytes(name).length <= 100);
        require(msg.sender == Owner.Adr);
        certifier[certifierAdr] = name;
    }
    
    function addCertificate(string certificateID) public {
        require(bytes(certificateID).length > 0 && bytes(certificateID).length <= 256);
        currentCertifier = "";
        currentCertifier = certifier[msg.sender];
        require(bytes(currentCertifier).length > 5);
        certificate[msg.sender] = certificateID;
    }
}
