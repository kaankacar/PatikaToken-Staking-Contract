# PatikaToken Staking Contract

This contract is used for staking operations of a token named "Patika".

## Token Information

- Token name: Patika
- Token symbol: PTK
- Total token supply: 1,000,000 PTK

# Variables, Functions, Events

## Variables

- `_name`: A private string variable representing the token name.
- `_symbol`: A private string variable representing the token symbol.
- `_decimals`: A private uint8 variable representing the decimal places of the token.
- `_totalSupply`: A private uint256 variable representing the total token supply.
- `_balances`: A private mapping variable tracking account balances by address.
- `_allowances`: A private mapping variable tracking approved balances by address and spending allowance.
- `_owner`: A private address variable representing the owner of the contract.
- `_stakingRewards`: A private mapping variable tracking staking rewards by address.
- `_lastStakeTimestamp`: A private mapping variable tracking the last stake timestamps by address.
- `_isStaked`: A private mapping variable tracking the staking status by address.

## Functions

- `name()`: A function that returns the token name.
- `symbol()`: A function that returns the token symbol.
- `decimals()`: A function that returns the decimal places of the token.
- `totalSupply()`: A function that returns the total token supply.
- `balanceOf(address account)`: A function that returns the account balance for the specified address.
- `transfer(address recipient, uint256 amount)`: A function that transfers a specified amount of tokens to the given address.
- `approve(address spender, uint256 amount)`: A function that approves a specified amount of spending allowance to the given address.
- `transferFrom(address sender, address recipient, uint256 amount)`: A function that transfers a specified amount of tokens from one address to another.
- `increaseAllowance(address spender, uint256 addedValue)`: A function that increases the spending allowance by the specified amount.
- `decreaseAllowance(address spender, uint256 subtractedValue)`: A function that decreases the spending allowance by the specified amount.
- `stake(uint256 amount)`: A function that includes the specified amount of tokens in the staking process.
- `claimReward()`: A function that allows claiming staking rewards.
- `isStaked(address account)`: A function that returns whether staking is performed at the specified address.
- `airdrop()`: A function that performs the distribution of a specific amount of tokens as airdrop.
- `transferOwnership(address newOwner)`: A function that transfers the contract ownership to another address.
- `transferTokens(address recipient, uint256 amount)`: A function that allows the contract owner to transfer a specified amount of tokens to the given address.

## Events

The contract can emit the following events:

- `Transfer(address indexed from, address indexed to, uint256 value)`: Triggered when a token transfer occurs.
- `Approval(address indexed owner, address indexed spender, uint256 value)`: Triggered when a spending allowance is approved.

## Test Results

- `should have correct initial values`: A test that checks if the initial values are correct. Successful.
- `should have total supply in the contract`: A test that checks if the total supply exists in the contract. Successful.
- `should execute the airdrop function`: A test that checks if the airdrop function executes successfully. Successful.

A total of 3 tests were performed, and all of them were successful.

## Contract Deployment Information

- Transaction hash: 0xd115d54d29b3710ab9cbb62ed602811603b648293350eea8cec2aa0acb2cf0d0
- Contract address: 0x7767d03fA08cFebd7cc9C78C84877eC09d0f902E


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
