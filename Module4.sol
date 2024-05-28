// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Degen is ERC20, Ownable {
    mapping(uint256 => uint256) public prices;

    constructor(address firstOwner)
        ERC20("Degen", "DGN")
        Ownable(firstOwner)
    {
        _mint(firstOwner, 600);
        prices[1] = 50;
        prices[2] = 100;
        prices[3] = 150;
    }

    function mint(address receiver, uint256 amount) public onlyOwner {
        require(amount > 0);
        _mint(receiver, amount);
    }

    function burn(uint256 amount) public onlyOwner {
        require(amount > 0 && balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function redeem(uint256 itemId) public {
        uint256 price = prices[itemId];
        _burn(msg.sender, price);
    }

    function balanceOf(address account) public view override returns (uint256) {
        return super.balanceOf(account);
    }
}
