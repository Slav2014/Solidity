pragma solidity ^0.4.24;

// DAPP for keeping informatio0n about pations using proxy


contract HelthCare
{
    // data here - Store Contract
   struct PationInfo 
   {
       string name;
       uint age;
       uint height;
       uint weight;
   }
   
   mapping (address => PationInfo) Pations;
   
   address public Delegate;
   
   
   constructor (address _orig) public
   {
       Delegate = _orig;
   }
    
    function setPationInfo (string _name, uint _age, uint _height, uint _weight ) public
    {
        
        Delegate.delegatecall(bytes4(keccak256("setPationInfo(string,uint256,uint256,uint256)")), _name, _age, _height, _weight);
    }
    
    
    function getPationInfo() public view returns (string, uint, uint, uint)
    {
        return (Pations[msg.sender].name, Pations[msg.sender].age, Pations[msg.sender].height, Pations[msg.sender].weight); 
    }
 
    
}

contract proxiHelthCare {
    // processing data here - Logic Contract
    struct PationInfo 
   {
       string name;
       uint age;
       uint height;
       uint weight;
       
   }
   
   mapping (address => PationInfo) Pations;
   
   function setPationInfo (string _name, uint _age, uint _height, uint _weight) public 
   {
    //   Pations[msg.sender].name = _name;
    //   Pations[msg.sender].age = _age;
    //   Pations[msg.sender].height = _height;
    //   Pations[msg.sender].weight = _weight;
       
       Pations[msg.sender] = PationInfo(_name, _age, _height, _weight);
       
   }

}