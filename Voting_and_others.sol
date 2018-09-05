pragma solidity ^0.4.24;

// Basic Addition contract ************************************************
// Add num:

contract Basic_addtion_contract
{
    function addNum(uint a, uint b) public pure returns (uint)
    {
        uint summ;
        summ = a + b;
        return summ;
    }
// Substract num:    
    function subNum(uint a, uint b) public pure returns (uint)
    {
        uint summ;
        summ = a - b;
        return summ;
    }
// Multiply num:
    function multiNum(uint a, uint b) public pure returns (uint)
    {
        uint summ;
        summ = a * b;
        return summ;
    }
// Divide num:
    function divNum(uint a, uint b) public pure returns (uint)
    {
        uint summ;
        summ = a / b;
        return summ;
    }
}

// Basic voting mapping *************************************************

// Create 3 functions and 3 modifier

contract Basic_voting_dapp
{
    // Voting ends after one minute
    constructor() public
    {
        election_over = now + 1 minutes;
    }
    
    
    // modifier election not over    
    modifier electionNotOver()
    {
        require (now < election_over);
        _;
    }
    
    // modifier election  over
       modifier electionOver()
        {
            require(now > election_over);
            _;
        }
    
    // No one can vote twice
    mapping (address => bool) voted;
    
     modifier hasNotVoted()
        {
            require(voted[msg.sender] == false);
            voted(msg.sender) = true;
            _;
        }

    // Vote for one of two condidates
   // vote for candidate A 
     function voteCandidateA() public hasNotVoted electionNotOver
    {
        canA++;
    }
   // vote for candidate B
    function voteCandidateB() public hasNotVoted electionNotOver
    {
        canB++;
    }
   
    // Getter function to declere winner after voting ends
    function whoWon() public electionOver() view returns (string)
    {
            if (canA > canB) return ("Candidate A won!");
        else if (canB > canA) return ("Candidate B won!");
        return ("It is Tie!");
            
    }
}

// Build an ERC20 token

contract ERC20
{
    mapping(address => uint) balances;

    // Owner has 1 million tokens
    
        constructor (uint _tot, string _name) public
    {
        name = _name;
        total = _total;
        owner = msg.sender;
        total = 1000000;
        balance[owner]= total;
    }

    // Buy tokens function, 1 ether buys 10,000 tokens
    function buyTokens() external payable
    {
        int btok;
        btok = 10000;
        require (msg.value > 0);
        require (balances[owner] >= (msg.value / 1 ether) * btok);
        balances[owner] -= (msg.value / 1 ether) * btok;
        balances[msg.sender] += (msg.value / 1 ether) * btok;
    }
    
    // Getter function to return the token balance of caller
    function selfBalance() public view returns (uint256)
    {
        return balances[msg.sender];
    }
    
    // Transfer token function 
    function transfer (address dest, uint256 amt) public
    {
        require (balances[msg.sender] >= amt);
        balances[msg.sender] -= amt;
        balances[dest] += amt;
   
    }
    
    // function that returns balance of given address
    function getBalance(address a) public view returns (uint256)
    {
        return a.balances[msg.sender];
    }
    
    // Modifier that only allows the owner to access a function
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // withdrawal function for contact owner
    
    function withdrawal() eternal payable onlyOwner
    {
        owner.transfer(address(this).balance);
    }
}    
 
 // ERC 721 token **********************************************
contract ERC721
{
    uint UID = 0;
  
        // mapping
         mapping (uint => address) uniqueAsset;
   
        // owner owns first 100 unique assets 
        constructor () public
        {
            total = _total;
            owner = msg.sender;
            total = 100;
            uniqueAsset[owner].balance = total;       
        }
        
        // transfer ownership function
        function transferAsset(uint256 asset, address to) public
        {
            require(uniqueAsset[asset] == msg.sender);
            uniqueAsset[asset] = to;
    
        }
        
        // getter function to return address of owner given token id
        function getOwner(uint256 asset) public returns (address)
        {
            return uniqueAsset[asset];
        }
        
        // function that allows user to buy a new unique asset
        function purchaseUniqueAsset(address asset, uint256 cost) public payable returns (uint256 id)
        {
        
            if (cost == 10 ether && msg.value >= 10 ether)
        {
        msg.sender.transfer(asset);
        balanceOf[asset].balance -= 10;
        address(this).balance += 10;
        return true;
        }
        else {return false;}
    
        }
        
    }



// ERC20 proxi contract *******************************************
    
    // implement all previous ERC20 logic

contract ERC20_p
{
    mapping(address => uint) balances;

    // Owner has 1 million tokens
    
        constructor (uint _tot, string _name) public
    {
        name = _name;
        total = _total;
        owner = msg.sender;
        total = 1000000;
        balance[owner]= total;
    }

    // Buy tokens function, 1 ether buys 10,000 tokens
    function buyTokens() external payable
    {
        int btok;
        btok = 10000;
        require (msg.value > 0);
        require (balances[owner] >= (msg.value / 1 ether) * btok);
        balances[owner] -= (msg.value / 1 ether) * btok;
        balances[msg.sender] += (msg.value / 1 ether) * btok;
    }
    
    // Getter function to return the token balance of caller
    function selfBalance() public view returns (uint256)
    {
        return balances[msg.sender];
    }
    
    // Transfer token function 
    function transfer (address dest, uint256 amt) public
    {
        require (balances[msg.sender] >= amt);
        balances[msg.sender] -= amt;
        balances[dest] += amt;
   
    }
    
    // function that returns balance of given address
    function getBalance(address a) public view returns (uint256)
    {
        return a.balances[msg.sender];
    }
    
    // Modifier that only allows the owner to access a function
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // withdrawal function for contact owner
    
    function withdrawal() eternal payable onlyOwner
    {
        owner.transfer(address(this).balance);
    }
}    
    
    // make a change proxi function that allows the owner to assign the delegatedCall to a new address 
        function changeProxi(address newProxi) public onlyOwner
        {
        Delegate.delegatecall(bytes4(keccak256("transfer (address dest, uint256 amt)")), newProxi);

        }

    
// Implment ICO and transfer function with a DelegatedCall to the proxi smart contract
    
contract ICO 
{
    address public beneficiary; 
    uint public fundingGoal; 
    uint public amountRaised; 
    uint public deadline; 
    uint public price; 

    mapping(address => uint256) public balanceOf; 
    
    bool fundingGoalReached = false; 
    bool crowdsaleClosed = false;
    
    
    function Crowdsale( 
        address ifSuccessfulSendTo,
        uint fundingGoalInEthers,
        uint durationInMinutes, 
        uint etherCostOfEachToken, 
        address addressOfTokenUsedAsReward 
        ) public {
        beneficiary = ifSuccessfulSendTo; 
        fundingGoal = fundingGoalInEthers * 1 ether; 
        deadline = now + durationInMinutes * 1 minutes; 
        price = etherCostOfEachToken * 1 ether; 
        tokenReward = token(addressOfTokenUsedAsReward); 
        }

    function () payable public { 
        require(!crowdsaleClosed); 
        uint amount = msg.value; 
        balanceOf[msg.sender] += amount; 
        amountRaised += amount; 
        Delegate.delegatecall(bytes4(keccak256("transfer (address dest, uint256 amt)")), msg.sender, amount / price);
    }
    

}
// ***************


