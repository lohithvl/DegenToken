# Degen Token

Degen Token (DGN) is an ERC20 token with additional features that include token purchasing, item purchases, token burning, and damage calculation for gaming scenarios. Built using Solidity and OpenZeppelin libraries, this contract serves as both a fungible token and a utility token for in-game transactions on the Ethereum blockchain.

## Description

The Degen Token contract offers various functionalities tailored for gaming. Users can:
- Purchase tokens with set limits.
- Buy in-game items using Degen Tokens, with different items priced accordingly.
- Burn tokens upon item purchases.
- Calculate damage based on attack power and defense in combat scenarios.
The contract also includes an event-driven architecture, where token purchases and item transactions emit events, allowing easy tracking of these actions on the blockchain.

## Getting Started

### Installing

To use or deploy this contract, follow these steps:
1. Clone the repository or download the contract files.
2. Ensure you have an Ethereum development environment (e.g., [Remix](https://remix.ethereum.org/), [Hardhat](https://hardhat.org/)).
3. Install necessary dependencies:
   ```bash
   npm install @openzeppelin/contracts
   ```

### Executing program

To deploy the contract:

1. Open your Ethereum development environment.
2. Compile the contract:
   ```bash
   npx hardhat compile
   ```
3. Deploy the contract:
   ```bash
   npx hardhat run scripts/deploy.js --network <network-name>
   ```
   Or in Remix, after compiling the contract, deploy it by specifying the initial supply in the constructor.

Once deployed, you can interact with the following functions:

- **purchaseTokens**: Buy tokens (limit of 100 per transaction).
   ```solidity
   purchaseTokens(uint amount)
   ```
- **buyItem**: Buy in-game items using tokens.
   ```solidity
   buyItem(uint itemId)
   ```
   Item IDs range from 1 to 3 with different prices.
  
- **calculateDamage**: Calculate the damage dealt by reducing defense from the attack power.
   ```solidity
   calculateDamage(uint attackPower, uint defense)
   ```

- **getBalance**: Get the balance of the user's Degen Tokens.
   ```solidity
   getBalance()
   ```

## Help

For common issues:
- Ensure that your Solidity version is `^0.8.17`.
- If deploying on a testnet or mainnet, ensure you have sufficient ETH for gas fees.

To check for contract help or logs, use the following:
```
npx hardhat help
```

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
