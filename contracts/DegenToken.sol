// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    string public GameBuffs;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner)  {
        GameBuffs = "We have 3 buffs 1. Magic Wand 2. Enchanted Shield 3. Speed Boots";
    }

    function buyItem(uint itemId) external {
        require(itemId >= 1 && itemId <= 3, "Invalid item ID");

        uint price;
        string memory itemName;

        if (itemId == 1) {
            price = 1;
            itemName = "Magic Wand";
        } else if (itemId == 2) {
            price = 3;
            itemName = "Enchanted Shield";
        } else if (itemId == 3) {
            price = 5;
            itemName = "Speed Boots";
        }

        require(balanceOf(msg.sender) >= price, "Insufficient balance");
        _burn(msg.sender, price);
    }

    function AttackBonus(uint attackPower, uint defense) external {
        require(attackPower > 0, "Attack power must be greater than zero");
        require(defense >= 0, "Defense must be zero or higher");

        uint reducedDamage = attackPower - (defense / 3);
        uint finalDamage = reducedDamage > 0 ? reducedDamage : 0;

        _mint(msg.sender, finalDamage);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public override {
        super.burn(amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        return super.transfer(recipient, amount);
    }

    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

}
