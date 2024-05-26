// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(uint256 => uint256) public itemPrices;

    event ItemRedeemed(address indexed redeemer, uint256 indexed itemId, uint256 price);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
        // Set initial item prices
        itemPrices[1] = 400;
        itemPrices[2] = 300;
        itemPrices[3] = 200;
        itemPrices[4] = 450;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }


    function redeem(uint256 itemId) public {
        uint256 price = itemPrices[itemId];
        require(price > 0, "Item not available for redemption");
        require(balanceOf(msg.sender) >= price, "Insufficient balance");

        _burn(msg.sender, price);
        emit ItemRedeemed(msg.sender, itemId, price);
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return super.balanceOf(account);
    }
}

