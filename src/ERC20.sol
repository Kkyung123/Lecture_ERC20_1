// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

constructor(){
    _name = "DREAM";
    _symbol = "DRM";
    _decimals = 18;
    _totalSupply = 100 ether;
    balances[msg.sender] = 100 ether;
}

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

function balanceOf(address _to) public view returns (uint256){
    return balances[_to];
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
    
    uint256 currentAllowance = allowance(_from, msg.sender);
    //if (currentAllowance != type(uint256.max)
    require(currentAllowance >= _value, "insufficient allowance");
    unchecked {
            allowances[_from][msg.sender] -= _value;
    }

    //from에서 to에게 value만큼 전송
    //from의 잔고는 to에게 전송한만큼 차감
    //to의 잔고는 from에게 전송받은만큼 증가
    //allowance(_from, msg.sender)는 transferFrom이 위탁하여 토큰을 전송할 수 있으므로
    require(balances[_from] >= _value, "vaule exceeds balance");
    unchecked {
        balances[_from] -= _value;
        balances[_to] += _value;
    }

    emit Transfer(_from, _to, _value);
    return true;
    }

function approve(address _to, uint256 _value) external returns (bool success){
    require(msg.sender != address(0), "transferfrom the zero address");
    allowances[msg.sender][_to] = _value;
    emit Approval(msg.sender, _to, _value);
    if(allowances[msg.sender][_to] > 0){
        return true;
    }
    else{
        return false;
    }
}

function allowance(address _to, address _from) public view returns (uint256){
    return allowances[_to][_from];
    }   

function _mint(address _to, uint256 _value) internal{
    require(_to != address(0), "transferfrom the zero address");
    require(balances[_to]+_value <= type(uint256).max);
    _totalSupply += _value;
    balances[_to] += _value;
    //토큰 발행만 해서 transfer 필요없음
}

function _burn(address _from, uint256 _value) internal{
    require(_from != address(0), "transferfrom the zero address");
    require(balances[_from] >= _value, "vaule exceeds balance");
    balances[_from] -= _value;
    _totalSupply -= _value;
}   

//function _pause : 토큰 전송 일시정지 상태
//fucntion _permit: approve가
event Transfer(address _to, address _from, uint256 _value);
event Approval(address _to, address _from, uint256 _value);

}
