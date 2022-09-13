// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    

function name() public view returns (string memory) {
    return _name;
    }

function symbol() public view returns (string memory){
    return _symbol;
    }

function decimals() public view returns (uint8){
    return _decimals;
    }

function totalSupply() public view returns (uint256){
    return _totalSupply;
    }   

function balanceOf() public view returns (uint256){
    return balances[_owner];
    }

function transfer(address _to, uint256 _value) external returns (bool success){
    require(balances[msg.sender] >= _value, "vaule exceeds balance");
    require(_to != address(0), "transfer to the zero address");
    require(balances[msg.sender] >= _value, "value exceeds balances");
    
    unchecked {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
    }

    emit Transfer(msg.sender, _to, _value);
    }

function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
    require(msg.sender != address(0), "transferfrom the zero address");
    require(_from != address(0), "transfer from the zero address");
    require(_to != address(0), "transfer to the zero address");
    
    uint256 currentAllowance = allowances(_from, msg.sender);
    require(currentAllowance >= _value, "insufficient allowance");
    unchecked {
        allowances[_from][msg.sender] -= _value;
    }

    require(balances[msg.sender] >= _value, "vaule exceeds balance");
    
    unchecked {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
    }

    emit Transfer(msg.sender, _to, _value);
    }

function approve(address _to, uint256 _value) external returns (bool success){
    require(msg.sender != address(0), "transferfrom the zero address");
    require(_from != address(0), "transfer from the zero address");
    require(msg.sender == owner);
    
    emit Approval(msg.sender, _to, _value);
    }

function allowance(address _to, address _from) public view returns (uint256 ){
    

    }

}
