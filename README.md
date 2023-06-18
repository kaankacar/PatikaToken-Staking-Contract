# PATIKA($PTK) STAKING CONTRACT

This $PTK staking contract is deployed on the BNB Chain and represents the Patika token (PTK).

## Token Information

- Token Name: Patika
- Token Symbol: PTK
- Blockchain: BNB Chain
- Smart Contract Address: 0xdb7CA9F0b7687687A01C134CF9b8F5D3eC7Bf3eA
- Total Supply: 1.000.000 $PTK
- Staking Rewards: 1% Daily

## Variables, Mappings and Functions

### Variables

- `STAKING_REWARD_RATE`: Private constant variable that represents the staking reward rate, set to 1% per day.
- `_totalStakedTokens`: Private variable that keeps track of the total amount of tokens staked in the contract.

### Mappings


- `mapping(address => uint256) private _stakingRewards`: This mapping keeps track of the staking rewards for each user. It associates each user's address with the corresponding staking reward amount.

- `mapping(address => uint256) private _lastStakeTimestamp`: This mapping stores the timestamp of the last stake made by each user. It associates each user's address with the corresponding last stake timestamp.

- `mapping(address => bool) private _isStaked`: This mapping keeps track of whether each user has staked tokens or not. It associates each user's address with a boolean value representing their staked status.

- `mapping(address => uint256) private _stakeBalanceOf`: This mapping stores the stake balance of each user. It associates each user's address with the amount of tokens they have staked.

### Functions

1. `getTotalTokenSupply()`: External function that returns the total token supply held by the contract.

2. `getTotalStakedTokens()`: External function that returns the total amount of tokens currently staked in the contract.

3. `stake(uint256 amount)`: External function that allows users to stake a specified amount of tokens. The function requires the user to have a sufficient token balance. Upon staking, the function calculates the staking reward, updates staking rewards, the last stake timestamp, and the user's staked status. The staked amount is transferred from the user's balance to the contract, and the staked balance for the user is updated.

4. `claimRewardsAndUnstake()`: External function that allows users to claim their staking rewards and unstake their tokens. The function checks if the user has staked tokens available for withdrawal. It calculates the reward duration and the total reward to be claimed based on the staking rewards and the duration of the stake. The staking rewards and last stake timestamp are reset, and the user's staked status is updated. The total amount to be transferred is calculated, and the reward and staked amount are transferred back to the user. The staked balance for the user is reset.

5. `airdrop()`: External function that allows the contract to perform an airdrop of tokens to the calling address. It transfers 100 $PTK from the contract's balance to the caller.

**Note:** The contract inherits from the `ERC20` and `Ownable` contracts provided by the OpenZeppelin library, which implement ERC-20 token functionality and ownership management, respectively.


## Test Results

- `should have correct initial values`: A test that checks if the initial values are correct. Successful.
- `should have total supply in the contract`: A test that checks if the total supply exists in the contract. Successful.
- `should execute the airdrop function`: A test that checks if the airdrop function executes successfully. Successful.

A total of 3 tests were performed, and all of them were successful.

## Contract Deployment Information

- Transaction hash: 0x23b6ad6da9c67fad9e9dcd478187f89114db881022aa67b3edcee2b1d37d6d90
- Contract address: 0xdb7CA9F0b7687687A01C134CF9b8F5D3eC7Bf3eA


# BNB Smart Chain Truffle Box

- [BNB Smart Chain Truffle Box](#bnb-smart-chain-truffle-box)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Setup](#setup)
    - [Using the env File](#using-the-env-file)
    - [New Configuration File](#new-configuration-file)
    - [New Directory Structure for Artifacts](#new-directory-structure-for-artifacts)
  - [BNB Smart Chain](#bnb-smart-chain)
    - [Compiling](#compiling)
    - [Migrating](#migrating)
    - [Paying for Migrations](#paying-for-migrations)
  - [Basic Commands](#basic-commands)
    - [Testing](#testing)
  - [Support](#support)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

This Truffle BNB Smart Chain box provides you with the boilerplate structure necessary to start coding on the BNB Smart Chain. For detailed information on how the BNB Smart Chain works, please see their documentation [here](https://docs.bnbchain.org/docs/getting-started).

As a starting point, this box contains only the ```SimpleStorage``` Solidity contract. Including minimal code was a conscious decision as this box is meant to provide the initial building blocks needed to get to work on BNB Smart Chain without pushing developers to write any particular sort of application. With this box, you will be able to compile, migrate, and test Solidity code against several instances of BNB Smart Chain networks.

The BNB Smart Chain is fully compatible with the EVM. This means you will not need a new compiler to deploy Solidity contracts, and should be able to add your own Solidity contracts to this project. The main difference developers will encounter is in accessing and interacting with the BNB Smart Chain network.

## Requirements

The BSC box has the following requirements:

- [Node.js](https://nodejs.org/) 10.x or later
- [NPM](https://docs.npmjs.com/cli/) version 5.2 or later
- Windows, Linux or MacOS

Helpful, but optional:

- A [MetaMask](https://metamask.io/) account

## Installation

```bash
truffle unbox bnb-chain/BSC-Truffle-Starter-Box
```

## Setup

### Using the env File

You will need at least one mnemonic to use with the network. The `.dotenv` npm package has been installed for you, and you will need to create a `.env` file for storing your mnemonic and any other needed private information.

The `.env` file is ignored by git in this project, to help protect your private data. In general, it is good security practice to avoid committing information about your private keys to github. The `truffle-config.bsc.js` file expects a `MNEMONIC` value to exist in `.env` for running migrations on the networks listed in `truffle-config.bsc.js`.

If you are unfamiliar with using `.env` for managing your mnemonics and other keys, the basic steps for doing so are below:

1. Use `touch .env` in the command line to create a `.env` file at the root of your project.
2. Open the `.env` file in your preferred IDE
3. Add the following, filling in your own mnemonic:

```
MNEMONIC="<Your Mnemonic>"
```

4. As you develop your project, you can put any other sensitive information in this file. You can access it from other files with `require('dotenv').config()` and refer to the variable you need with `process.env['<YOUR_VARIABLE>']`.

### New Configuration File

A new configuration file exists in this project: `truffle-config.bsc.js`. This file contains a reference to the new file location of the `contracts_build_directory` for BNB Smart Chain contracts and lists several networks that are running the BNB Smart Chain network instance (see [below](#migrating)).

Please note, the classic `truffle-config.js` configuration file is included here as well, because you will eventually want to deploy contracts to on localhost for local development. All normal truffle commands (`truffle compile`, `truffle migrate`, etc.) will use this config file and save built files to `build/local-contracts`. You can save Solidity contracts that you wish to deploy to Ethereum in the `contracts/local-dev` folder.

### New Directory Structure for Artifacts

When you compile or migrate, the resulting `json` files will be at `build/bsc-contracts/`. This is to distinguish them from contracts you build for any other network other than BSC. As we have included the appropriate `contracts_build_directory` in each configuration file, Truffle will know which set of built files to reference!

## BNB Smart Chain

### Compiling

You do not need to add any new compilers or settings to compile your contracts for the BNB Smart Chain, as it is fully EVM compatible. The `truffle-config.bsc.js` configuration file indicates the contract and build paths for BSC-destined contracts.

If you are compiling contracts specifically for the BNB Smart Chain network, use the following command, which indicates the appropriate configuration file:

```
npm run compile:bsc
```

If you would like to recompile previously compiled contracts, you can manually run this command with
`truffle compile --config=truffle-config.bsc.js` and add the `--all` flag.

### Migrating

To migrate on the BNB Smart Chain network, run `npm run migrate:bsc --network=(bscTestnet | bscMainnet)` (remember to choose a network from these options!).

As you can see, you have two BSC networks to choose from:

- `bscTestnet`: This is the BNB Smart Chain testnet.
- `bscMainnet`: This is the BNB Smart Chain mainnet. Caution! If you deploy to this network using a connected wallet, the fees are charged in mainnet BNB.

If you would like to migrate previously migrated contracts on the same network, you can run `truffle migrate --config truffle-config.bsc.js --network= (bscTestnet | bscMainnet)` and add the `--reset` flag.

### Paying for Migrations

To pay for your deployments, you will need to have an account with BNB available to spend. You will need your mnemomic phrase (saved in the `.env` file or through some other secure method). The first account generated by the seed needs to have the BNB you need to deploy. 

If you do not have a wallet with funds to deploy, you will need to connect a wallet to at least one of the networks above. For testing, this means you will want to connect a wallet to the `BSC Testnet` network. We recommend using [MetaMask](https://metamask.io/).

Documentation for how to set up MetaMask to configure custom network like BSc Testnet can be found [here](https://academy.binance.com/en/articles/connecting-metamask-to-binance-smart-chain).

Follow the steps in the documentation above using the BNB Smart Chain RPC endpoints (`https://docs.bnbchain.org/docs/rpc`). The `chainId` values are the same as those in the `truffle-config.bsc.js` networks entries.

To get testnet BNB tokens use the official [faucet](https://testnet.binance.org/faucet-smart).

## Basic Commands

The code here will allow you to compile, migrate, and test your code on the BNB Smart Chain. The following commands can be run (more details on each can be found in the next section):

To compile:

```
npm run compile:bsc
```

To migrate:

```
npm run migrate:bsc --network=(bscTestnet | bscMainnet)
```

To test:

```
npm run test:bsc --network=(bscTestnet | bscMainnet)
```

### Testing

In order to run the test currently in the boilerplate, use the following command: `npm run test:bsc --network=(bscTestnet | bscMainnet)` (remember to choose a network!). The current test file just has some boilerplate tests to get you started. You will likely want to add network-specific tests to ensure your contracts are behaving as expected.


## Support

Support for this box is available via the Truffle community [here](https://www.trufflesuite.com/community) or on our official [Discord Channel](https://discord.com/channels/789402563035660308/912296662834241597).
