// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor(uint initialSupply) ERC20("Degen Token", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    event ItemPurchased(address indexed buyer, uint indexed itemId, string itemName, uint price);
    event TokensPurchased(address indexed buyer, uint amount);
    event BonusIssued(address indexed recipient, uint bonusAmount);

    // Modified purchaseTokens to include a purchase limit
    function purchaseTokens(uint amount) external {
        require(amount > 0 && amount <= 100, "Amount must be between 1 and 100"); // Limit token purchase
        _mint(msg.sender, amount);
        emit TokensPurchased(msg.sender, amount);
    }

    // New buyItem function to include different item prices and a bonus for higher items
    function buyItem(uint itemId) external {
        require(itemId >= 1 && itemId <= 5, "Invalid item ID");

        uint price;
        string memory itemName;

        if (itemId == 1) {
            price = 1;
            itemName = "Magic Wand";
        } else if (itemId == 2) {
            price = 3; // Increased price
            itemName = "Enchanted Shield";
        } else if (itemId == 3) {
            price = 5; 
            itemName = "Speed Boots";
        } 

        require(balanceOf(msg.sender) >= price, "Insufficient balance");

        _burn(msg.sender, price);

        emit ItemPurchased(msg.sender, itemId, itemName, price);
    }

    // Modified bonus function: now can only be called after a purchase
    function calculateDamage(uint attackPower, uint defense) external pure returns (uint) {
    require(attackPower > 0, "Attack power must be greater than zero");
    require(defense >= 0, "Defense must be zero or higher");

    // Step 1: Calculate reduced damage based on defense
    uint reducedDamage = attackPower - (defense / 3); // Reduce defense's impact by 1/3

    // Step 2: Ensure damage does not go below zero
    uint finalDamage = reducedDamage > 0 ? reducedDamage : 0;

    return finalDamage;
}


    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
