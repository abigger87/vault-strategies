<h3 align="center">Rari Vault Strategies</h3>

<div align="center">

[![Tests](https://github.com/abigger87/vault-strategies/actions/workflows/tests.yml/badge.svg)](https://github.com/abigger87/vault-strategies/actions/workflows/tests.yml)
[![Lints](https://github.com/abigger87/vault-strategies/actions/workflows/lints.yml/badge.svg)](https://github.com/abigger87/vault-strategies/actions/workflows/lints.yml)
[![License](https://img.shields.io/badge/License-AGPL--3.0-blue)](LICENSE.md)

</div>

<p align="center">Simple (potentially composable) Strategies for earning yield on Rari Vaults.</p>

### Credits

-   [t11s](https://twitter.com/transmissions11), [Jet Jadeja](https://twitter.com/JetJadeja), and the whole [Rari Capital](https://twitter.com/raricapital) team for their work on vaults.
- Rain's [crop](https://github.com/rainbreak/crop) Compound Levered USDC Strategy.
-   [Georgios Konstantopoulos](https://github.com/gakonst) for the amazing [dapptools-template](https://github.com/gakonst/dapptools-template) resource.

## Strategies

- [`IdleStrategy.sol`](src/IdleStrategy.sol): An Idle Strategy which generates no yield for a user's deposit.
- [`UniswapLP.sol`](src/UniswapLP.sol): Provides liquidity into a pool with the underlying and highest fees/liquidity ratio.
  - [Uniswap Deploys](https://github.com/Uniswap/v3-periphery/blob/main/deploys.md)
- [`CompoundLender.sol`](src/CompoundLender.sol): Lends the underlying to compound.
  - [Compound V2 Deploys](https://compound.finance/docs#networks)

## 
- [`interfaces/`](src/interfaces): Interfaces of external contracts Vaults and modules interact with.
  - [`Strategy.sol`](src/interfaces/Strategy.sol): Minimal interfaces for ERC20 and ETH compatible strategies.

## Contributing

Install [DappTools](https://dapp.tools) with the official [installation guide](https://github.com/dapphub/dapptools#installation).

### Setup

```sh
git clone https://github.com/abigger87/vault-strategies.git
cd vault-strategies
make
```

### Run Tests

```sh
dapp test
```

### Measure Coverage

```sh
dapp test --coverage
```

### Update Gas Snapshots

```sh
dapp snapshot
```

### Kovan

Rari Capital [VaultFactory](https://kovan.etherscan.io/address/0xc99a698dfB1eB38E0649e6d2d3462Bc2476dE0B4) at `0xc99a698dfB1eB38E0649e6d2d3462Bc2476dE0B4`

Underlying Token [RAI](https://kovan.etherscan.io/token/0x76b06a2f6df6f0514e7bec52a9afb3f603b477cd) at `0x76b06a2f6df6f0514e7bec52a9afb3f603b477cd`

Deployed [Vault](https://kovan.etherscan.io/address/0x58a4cc1f3c268af914c7f23fb1c7510c3033cbca) ad `0x58a4cc1f3c268af914c7f23fb1c7510c3033cbca`


#### Deployed Rai Vault

Using our previously deployed vault as the underlying, deployed
[Vault](https://kovan.etherscan.io/address/0xf4e6b1e4f4605c9a43bfa67ba30045ff2a6966a8) at `0xf4e6b1e4f4605c9a43bfa67ba30045ff2a6966a8`


Uniswap Liquidity [pool](https://app.uniswap.org/#/pool/8849)



Deployed Strategy to Kovan running:

```sh
dapp create src/IdleStrategy.sol:IdleStrategy <ETH_FROM> 0x76b06a2f6df6f0514e7bec52a9afb3f603b477cd --verify
```

Then verified with:

```
dapp verify-contract ./src/IdleStrategy.sol:IdleStrategy <Deployed IdleStrategy Address> <ETH_FROM> 0x76b06a2f6df6f0514e7bec52a9afb3f603b477cd
```


#### Compound Lender

Deployed Vault for Dai on Kovan at [0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a](https://kovan.etherscan.io/address/0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a).

Kovan Authority at [0x082220f9c151192542C547f56305c78C1f032513](https://kovan.etherscan.io/address/0x082220f9c151192542C547f56305c78C1f032513)

Deployed `CompoundLender`:

```bash
dapp create src/CompoundLender.sol:CompoundLender 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa // Dai
0xF0d0EB522cfa50B716B3b1604C4F0fA6f04376AD // cDai
0x61460874a7196d6a22D1eE4922473664b3E95270 // COMP
0x5eAe89DC1C671724A672ff0630122ee834098657 // Comptroller
0x082220f9c151192542C547f56305c78C1f032513 // Authority
--verify
```

Verified:

```bash
dapp verify-contract src/CompoundLender.sol:CompoundLender
0x8c8cfd425982ae12df541c4a9ac3a95ad344e548 // deployed CompoundLender address
0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa // Dai
0xF0d0EB522cfa50B716B3b1604C4F0fA6f04376AD // cDai
0x61460874a7196d6a22D1eE4922473664b3E95270 // COMP
0x5eAe89DC1C671724A672ff0630122ee834098657 // Comptroller
0x082220f9c151192542C547f56305c78C1f032513 // Authority
--verify
```

Deployed and Verified at [0x8c8cfd425982ae12df541c4a9ac3a95ad344e548](https://kovan.etherscan.io/address/0x8c8cfd425982ae12df541c4a9ac3a95ad344e548)

Call the trustStrategy function on the Kovan Dai Vault at [0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a](https://kovan.etherscan.io/address/0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a).

Trust the strategy from the DAI Vault:

```bash
seth send 0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a 'trustStrategy(address)' 0x8c8cfd425982ae12df541c4a9ac3a95ad344e548
```

Deposit into the Vault:

```bash
seth send 0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a 'deposit(uint256)' 10000000000000000000
```

Deposit from the Vault into the Strategy:

```bash
seth send 0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a 'depositIntoStrategy(address,uint256)' 0x8c8cfd425982ae12df541c4a9ac3a95ad344e548 10000000000000000000
```

Mint cDai with the dai holdings by calling `strategy.allocate`:

```bash
seth send 0x8c8cfd425982ae12df541c4a9ac3a95ad344e548 'allocate(uint256)' 10000000000000000000
```

Get strategy balance of the underlying:

```bash
seth call 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa 'balanceOf(address)' 0x8c8cfd425982ae12df541c4a9ac3a95ad344e548
```

Get strategy balance of the CToken:

```bash
seth call 0xF0d0EB522cfa50B716B3b1604C4F0fA6f04376AD 'balanceOf(address)' 0x8c8cfd425982ae12df541c4a9ac3a95ad344e548
```

Get the supply rate of cDai:

```bash
seth call 0xF0d0EB522cfa50B716B3b1604C4F0fA6f04376AD 'supplyRatePerBlock()'
```

Previous Versions:
- 0x6fbaa770f82f7d5f510b99c357e85123b4ac5558


#### Idle Strategy

Deployed Vault for Dai on Kovan at [0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a](https://kovan.etherscan.io/address/0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a).

Kovan Authority at [0x082220f9c151192542C547f56305c78C1f032513](https://kovan.etherscan.io/address/0x082220f9c151192542C547f56305c78C1f032513)

Deployed `IdleStrategy` with Dai as the underlying:

```bash
dapp create src/IdleStrategy.sol:IdleStrategy 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa 
--verify
```

Verified with Dai underlying and deployed address:

```bash
dapp verify-contract src/IdleStrategy.sol:IdleStrategy 0x9Cf345b0C01F58ff82F8dF3a1aa4d4594605e965 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa --verify
```

Deployed and Verified at [0x9Cf345b0C01F58ff82F8dF3a1aa4d4594605e965](https://kovan.etherscan.io/address/0x9Cf345b0C01F58ff82F8dF3a1aa4d4594605e965)

Call the trustStrategy function on the Kovan Dai Vault at [0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a](https://kovan.etherscan.io/address/0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a).

```bash
seth send 0xeD23CA589e7d0e714F70b6C5816d87aeDaed3f5a 'trustStrategy(address)' 0x9Cf345b0C01F58ff82F8dF3a1aa4d4594605e965
```


### Generate Pretty Visuals

We use [surya](https://github.com/ConsenSys/surya) to create contract diagrams.

Run `yarn visualize` to generate an amalgamated contract visualization in the `./assets/` directory. Or use the below commands for each respective contract.
