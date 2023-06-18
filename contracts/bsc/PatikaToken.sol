// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PatikaToken is ERC20, Ownable {
    uint256 private constant STAKING_REWARD_RATE = 1; // 1% per day
    uint256 private _totalStakedTokens;

    mapping(address => uint256) private _stakingRewards;
    mapping(address => uint256) private _lastStakeTimestamp;
    mapping(address => bool) private _isStaked;
    mapping(address => uint256) private _stakeBalanceOf; 

    constructor() ERC20("Patika", "PTK") {
        uint256 initialSupply = 1_000_000 * (10**decimals());
        _mint(address(this), initialSupply);
        _totalStakedTokens = 0;
    }

    function getTotalTokenSupply() external view returns (uint256) {
        return balanceOf(address(this));
    }

    function getTotalStakedTokens() external view returns (uint256) {
        return _totalStakedTokens;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        uint256 reward = (amount * STAKING_REWARD_RATE) / 100;
        _stakingRewards[msg.sender] += reward;
        _lastStakeTimestamp[msg.sender] = block.timestamp;
        _isStaked[msg.sender] = true;
        _transfer(msg.sender, address(this), amount);
        _totalStakedTokens += amount;
        _stakeBalanceOf[msg.sender] += amount; 
    }

    function claimRewardsAndUnstake() external {
    require(_isStaked[msg.sender], "No staked tokens available for withdrawal");

    uint256 durationSeconds = block.timestamp - _lastStakeTimestamp[msg.sender];
    uint256 reward = (_stakingRewards[msg.sender] * durationSeconds) / (1 days);
    _stakingRewards[msg.sender] = 0;
    _lastStakeTimestamp[msg.sender] = 0;
    _isStaked[msg.sender] = false;
    uint256 totalAmount = _stakeBalanceOf[msg.sender] + reward;
    _transfer(address(this), msg.sender, totalAmount);
    _totalStakedTokens -= _stakeBalanceOf[msg.sender];
    _stakeBalanceOf[msg.sender] = 0; 
    
    }



    function airdrop() external {
        uint256 amount = 100 * (10**decimals());
        require(balanceOf(address(this)) >= amount, "Insufficient balance in the contract");

        _transfer(address(this), msg.sender, amount);
    }
}