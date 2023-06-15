// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract PatikaToken {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    address private _owner;
    uint256 private constant TOTAL_SUPPLY = 1_000_000 * (10**18);
    uint256 private constant STAKING_REWARD_RATE = 1; // 1% per day

    mapping(address => uint256) private _stakingRewards;
    mapping(address => uint256) private _lastStakeTimestamp;
    mapping(address => bool) private _isStaked;

    constructor() public {
    _name = "Patika";
    _symbol = "PTK";
    _decimals = 18;
    _totalSupply = TOTAL_SUPPLY;
    _owner = msg.sender;
    _balances[address(this)] = TOTAL_SUPPLY;
}

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        require(recipient != address(0), "Invalid recipient address");
        require(amount <= _balances[msg.sender], "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        require(sender != address(0), "Invalid sender address");
        require(recipient != address(0), "Invalid recipient address");
        require(amount <= _balances[sender], "Insufficient balance");
        require(amount <= _allowances[sender][msg.sender], "Insufficient allowance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) external returns (bool) {
        require(spender != address(0), "Invalid spender address");

        _allowances[msg.sender][spender] += addedValue;

        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) {
        require(spender != address(0), "Invalid spender address");

        uint256 currentAllowance = _allowances[msg.sender][spender];
        require(currentAllowance >= subtractedValue, "Decreased allowance below zero");

        _allowances[msg.sender][spender] = currentAllowance - subtractedValue;

        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        // Calculate the staking reward
        uint256 reward = (amount * STAKING_REWARD_RATE) / 100;

        // Update staking rewards, the last stake timestamp, and mark user as staked
        _stakingRewards[msg.sender] += reward;
        _lastStakeTimestamp[msg.sender] = block.timestamp;
        _isStaked[msg.sender] = true;

        // Transfer the staked amount
        _balances[msg.sender] -= amount;
        _balances[address(this)] += amount;

        emit Transfer(msg.sender, address(this), amount);
    }

    function claimReward() external {
        require(_stakingRewards[msg.sender] > 0, "No staking rewards available");

        // Calculate the reward duration in days
        uint256 durationDays = (block.timestamp - _lastStakeTimestamp[msg.sender]) / 1 days;

        // Calculate the total reward to be claimed
        uint256 reward = (_stakingRewards[msg.sender] * durationDays) / STAKING_REWARD_RATE;

        // Update staking rewards, the last stake timestamp, and mark user as not staked if rewards are claimed in full
        _stakingRewards[msg.sender] -= reward;
        _lastStakeTimestamp[msg.sender] = block.timestamp;
        if (_stakingRewards[msg.sender] == 0) {
            _isStaked[msg.sender] = false;
        }

        // Transfer the reward to the staker
        _balances[address(this)] -= reward;
        _balances[msg.sender] += reward;

        emit Transfer(address(this), msg.sender, reward);
    }

    function isStaked(address account) external view returns (bool) {
        return _isStaked[account];
    }

    function airdrop() external {
        uint256 amount = 100 * (10**uint256(_decimals));
        require(_balances[address(this)] >= amount, "Insufficient balance in the contract");

        _balances[address(this)] -= amount;
        _balances[msg.sender] += amount;

        emit Transfer(address(this), msg.sender, amount);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner");
        _owner = newOwner;
    }

    function transferTokens(address recipient, uint256 amount) external onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(amount > 0, "Amount must be greater than zero");
        require(_balances[address(this)] >= amount, "Insufficient balance in the contract");

        _balances[address(this)] -= amount;
        _balances[recipient] += amount;

        emit Transfer(address(this), recipient, amount);
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the contract owner can call this function");
        _;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}



// > transaction hash:    0x9569a7602867c04790b45d909e8e81267b4672f4ef22f14d0e1dfef3632d720e
//    > Blocks: 2            Seconds: 4
//    > contract address:    0xB154dF2C4906eA4074455475726478cb52389fb5
//    > block number:        30698404
//    > block timestamp:     1686790163

//    --------------------------------
//    > confirmation number: 1 (block: 30698406)
//    > confirmation number: 2 (block: 30698407)
//    > confirmation number: 4 (block: 30698409)
//    > confirmation number: 5 (block: 30698410)
//    > confirmation number: 6 (block: 30698411)
//    > confirmation number: 8 (block: 30698413)
//    > confirmation number: 9 (block: 30698414)
//    > confirmation number: 10 (block: 30698415)
// export const PatikaTokenAddress =  + PatikaTokenAddress
//    > Saving artifacts
//    -------------------------------------
//    > Total cost:          0.02184878 ETH

// Summary
// =======
// > Total deployments:   1
// > Final cost:          0.02184878 ETH