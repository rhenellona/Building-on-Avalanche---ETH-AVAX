// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(uint256 => uint256) public KinsClass;

    event KinsClassRedeemed(address indexed redeemer, uint256 indexed kinId, uint256 price);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);

        KinsClass[1] = 400;
        KinsClass[2] = 300;
        KinsClass[3] = 20;
        KinsClass[4] = 450;
    }

    function checkDGNTokenBal() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function mintToken(address to, uint256 amount) public onlyOwner {
        require(amount >= 250, "Amount to be minted should be greater than or equal to 250");
        _mint(to, amount);
    }

    function burnToken(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transferToken(address recipient, uint256 amount) public virtual returns (bool) {
        require(amount <= balanceOf(_msgSender()), "ERC20: transfer amount exceeds balance");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeemKinClass(uint256 kinId) external {
        uint256 kinPrice = KinsClass[kinId];
        require(kinPrice > 0, "Kins Class does not exist");
        require(balanceOf(msg.sender) >= kinPrice, "Insufficient balance");

        _transfer(msg.sender, address(this), kinPrice);

        delete KinsClass[kinId];
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return super.balanceOf(account);
    }

    function getKinsClassPrice(uint256 kinId) public view returns (uint256) {
        require(KinsClass[kinId] > 0, "No existing KinID");
        return KinsClass[kinId];
    }
}
