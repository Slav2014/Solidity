pragma solidity ^0.4.24;

// mint coins for all Hobos and transfer them to the new owners (investors)

contract SafeMath { // safeguard a way variables are added, extracted, multiplied and divided
    function safeAdd(uint a, uint b) public pure returns (uint c) { // add
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) { // extract
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) { // multiply
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) { // divide
        require(b > 0);
        c = a / b;
    }
}

contract Main {
    HoboCoin[] newCoins;
    address owner;
    
    struct HoboInfo 
    {
        uint hoboID;
        address profile;
    }
    
    mapping(address => HoboInfo) Hobos;
    
    address public Delegate;
    
    constructor (address _orig) public
    {
        owner = msg.sender;
        Delegate = _orig;
    }
    
    function setHoboInfo(uint _ID) public
    {
        Delegate.delegatecall(bytes4(keccak256("setHoboInfo(uint256)")), _ID);
        
    }
    
    function getHoboContract(address _address) public view returns (address)
    {
        return (Hobos[_address].profile);
    }
}

contract proxyHobo {
    HoboCoin[] newCoins;
    struct HoboInfo 
    {
        uint hoboID;
        address profile;
    }
    
    mapping(address => HoboInfo) Hobos;
    
    //PatientInfo[] patients;
    
    function setHoboInfo(uint _ID) public returns(string, address)
    {
        // needs to check if the patients info has already been stored
        HoboCoin newInstance = new HoboCoin(msg.sender, _ID);
        newCoins.push(newInstance);
        Hobos[msg.sender].profile = newInstance;
        Hobos[msg.sender] = HoboInfo(_ID, newInstance);
        return ("Your contract address is: ", newInstance;
    }
}

contract HoboCoin {
    
    address public owner;
    uint public total = 100000;
    uint public tokenID;
    mapping (address => uint) public token;
    
    constructor (address _hobo, uint _ID) public 
    {
        owner = _hobo;
        _ID = tokenID;
        token[owner] = total; // minting tokens
    }
    
    modifier isOwner {
        require(msg.sender == owner);
        _;
    }
    
    function purchaseICO() external payable
    {
        require(msg.value > 0);
        require(token[owner] >= (msg.value / 1 ether) * 1000);
        token[owner] -= (msg.value / 1 ether) * 1000;
        token[msg.sender] += (msg.value / 1 ether) * 1000;
    }
    
    // function transferTokens (address _investor, uint _value) external payable {
    //     require(token[msg.sender] >= _value);
    //     token[msg.sender] -= _value;
    //     token[_newAddress] += _value;
    // }
    
    function viewBalance(address _owner) public view returns (uint balance) 
    {
        return token[_owner];
    }
    
    function withdrawEth() public payable isOwner
    {
        msg.sender.transfer(address(this).balance);
    }
}