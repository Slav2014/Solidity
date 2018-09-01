pragma solidity ^0.4.24;

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
        uint age;
        address profile;
    }
    
    mapping(address => HoboInfo) Hobos;
    mapping(string => address) hoboContracts;
    
    address public Delegate;
    
    constructor (address _orig) public
    {
        owner = msg.sender;
        Delegate = _orig;
    }
    
    function setHoboInfo(string _name, uint _age) public
    {
        Delegate.delegatecall(bytes4(keccak256("setHoboInfo(string,uint256)")), _name, _age);
        HoboCoin newInstance = new HoboCoin(msg.sender, _name);
    }
    
    function getPatientInfo() public view returns (string, uint, address)
    {
        return (Hobos[msg.sender].name, Hobos[msg.sender].age, Hobos[msg.sender].profile);
    }
}

contract proxyHobo {
    struct HoboInfo 
    {
        string name;
        uint age;
        address profile;
    }
    
    mapping(address => HoboInfo) Hobos;
    
    //PatientInfo[] patients;
    
    function setHoboInfo(string _name, uint _age, address _contract) public
    {
        // needs to check if the patients info has already been stored
        Hobos[msg.sender] = HoboInfo(_name, _age, _contract);
    }
}

contract HoboCoin is Main {
    
    address public owner;
    uint public total = 100000;
    string public name;
    mapping (address => uint) public token;
    
    constructor (address _hobo, string _name) public 
    {
        owner = _hobo;
        _name = name;
        token[owner] = total;
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