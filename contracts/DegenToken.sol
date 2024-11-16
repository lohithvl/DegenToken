// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    string public GameBuffs;
 struct Item {
        string name;
        uint256 redeemAmount;
    }
     mapping(uint256 => Item) public items;
    mapping(address => mapping(uint256 => uint256)) public redeemedItems; 

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        GameBuffs = "We have 3 buffs 1. Magic Wand 2. Enchanted Shield 3. Speed Boots";

        items[1] = Item("Magic Wand",1);
        items[2] = Item("Enchanted Shield",3);
        items[3] = Item("Speed Boots",5);
    }

    function buyItem(uint itemId) external payable  {
        require(itemId >= 1 && itemId <= 3, "Invalid item ID");
        uint price;
        if (itemId == 1) {
            price = 1;
        } else if (itemId == 2) {
            price = 3;          
        } else if (itemId == 3) {
            price = 5;
        }
        require(balanceOf(msg.sender) >= price, "Insufficient balance");
        _burn(msg.sender, price);

        redeemedItems[msg.sender][itemId] += 1;
    }

    function getRedeemedItems(address user, uint256 item) external view returns (uint256) {
        return redeemedItems[user][item];
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
