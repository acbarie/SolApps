pragma solidity ^0.4.22;

// single copy mode
contract imgShop {
    struct imageData{
        string fileInfo;
        uint256 hashValue;
        address producer;    
        string deliveryEmail;
    }
    
    imageData public image;
    
    struct trxData{
        address ID;
        uint price;
    }
    
    trxData public lastSeller;
    trxData public Owner;

    uint public currentPrice;

    bool onSale;
    bool onTrx;
  
    constructor(string info, uint256 imageHash) public {
        require(bytes(info).length > 0 && bytes(info).length <= 16);
        require(imageHash!=0);
        image.fileInfo = info;
        image.hashValue = imageHash;
        image.producer = msg.sender;
        
        lastSeller.ID = msg.sender;
        lastSeller.price = 999999 * 1 ether;
        Owner.ID = msg.sender;
        Owner.price = 999999 * 1 ether;
        
        onSale = false;
        onTrx = false;
    }
    
    function advertise(uint price) public {
        require(msg.sender == Owner.ID);
        require(price > 0);
        Owner.price = price * 1 wei;
        currentPrice = Owner.price;
        onSale = true;
    }
    
    function cancelSelling() public {
        require(msg.sender == Owner.ID);
        require (onSale);
        
        onSale = false;
        Owner.price = 999999 * 1 ether;
        currentPrice = 0;
    }
    
    modifier noReentrancy() {
        require(!onTrx);
        onTrx = true;
        _;
        onTrx = false;
    }
    
    function buy(string buyeremail) noReentrancy public payable {
        require (onSale);
        require(msg.value >= Owner.price);
        
        Owner.ID.transfer(msg.value);
        lastSeller.ID = Owner.ID;
        lastSeller.price = msg.value;
        
        Owner.ID = msg.sender;
        
        onSale = false;
        Owner.price = 999999 * 1 ether;
        currentPrice = 0;
        image.deliveryEmail = buyeremail;
    }
    
}