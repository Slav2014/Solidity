pragma solidity ^0.4.24;

contract StorageContract {

    uint public n;
    address public sender;

    mapping (address => uint) balance;
    address public Delegate;
  
	//pass the address of the logic contract in here
   constructor (address set) public
   {
       balance[msg.sender] = 100000000;
       Delegate = set;
   }

    function sendTokens(address to, address from, uint amt) public 
    {
        require(from == msg.sender && balance[from] >= amt);
        Delegate.delegatecall(bytes4(keccak256("sendTokens(address,address,uint256)")), to, from, amt);
    	//fill in this delegate call
	}
  
    function getTokenAmt() public view returns (uint256)
    {
        return balance[msg.sender];
    }
}

contract logic {
  
  uint public n;
  address public sender;
   mapping (address => uint) balance;

  function sendTokens(address to, address from, uint amt) public
  {
    balance[from] -= amt;
    balance[to] += amt;
  }
  
  function getAddy() public view returns (address)
  {
      return address(this);
  }
}
