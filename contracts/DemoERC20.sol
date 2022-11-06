// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract DemoERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply_;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from , address indexed to, uint tokens);

    constructor(string memory name_, string memory symbol_, uint256 total){
      name = name_;
      symbol = symbol_;
      totalSupply_ = total;
      decimals = 18;

      balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
      return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
      return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
      require(numTokens <= balances[msg.sender]);

      balances[msg.sender] = balances[msg.sender] - numTokens;
      balances[receiver] = balances[receiver] + numTokens;

      emit Transfer(msg.sender, receiver, numTokens);
 
      return true;
    }

    function transferFrom(address owner, address buyer, uint numTokens) public returns(bool) {
      require(numTokens <= balances[owner]);
      require(numTokens <= allowed[owner][msg.sender]);

      balances[owner] = balances[owner] - numTokens;
      allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;

      balances[buyer] = balances[buyer] + numTokens;
      emit Transfer(owner, buyer, numTokens);

      return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
      return allowed[owner][delegate];
    }

    function approve(address spender, uint256 numTokens) public returns (bool) {
      allowed[msg.sender][spender] = numTokens;

      emit Approval(msg.sender, spender, numTokens);
      
      return true;
    }
}
