// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {
    struct KinsClass {
        uint256 price;
        string name;
    }

    mapping(uint256 => KinsClass) public kinsClasses;
    mapping(address => uint256[]) private redeemedKinsClasses;

    event KinsClassRedeemed(address indexed redeemer, uint256 indexed kinId, uint256 price);
    event RedemptionSuccess(address indexed redeemer, uint256 indexed kinId, string message); // New event

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply);
    }

    function checkDGNTokenBal() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function mintToken(address to, uint256 amount) public {
        require(amount >= 250, "Amount to be minted should be greater than or equal to 250");
        _mint(to, amount);
    }

    function burnToken(uint256 amount) public {
        require(amount >= 20, "Amount to be burned should be greater than or equal to 20");
        _burn(msg.sender, amount);
    }

    function transferToken(address recipient, uint256 amount) public returns (bool) {
        require(amount <= balanceOf(_msgSender()), "ERC20: transfer amount exceeds balance");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function createKinsClass(uint256 kinId, uint256 price, string memory name) public {
        require(kinsClasses[kinId].price == 0, "Kins Class already exists");
        require(price > 0, "Price must be greater than zero");
        kinsClasses[kinId] = KinsClass(price, name);
    }

    function redeemKinsClass(uint256 kinId) external {
        KinsClass storage kinsClass = kinsClasses[kinId]; 
        require(bytes(kinsClass.name).length > 0, "Kins Class does not exist"); 
        uint256 price = kinsClass.price; 
        require(balanceOf(msg.sender) >= price, "You don't have enough balance"); 

        uint256[] storage redeemedIds = redeemedKinsClasses[msg.sender];
        for (uint256 i = 0; i < redeemedIds.length; i++) {
            require(redeemedIds[i] != kinId, "You've already redeemed this.");
        }

        _transfer(msg.sender, address(this), price); 
        redeemedKinsClasses[msg.sender].push(kinId); 
        emit KinsClassRedeemed(msg.sender, kinId, price);
    }

    function getRedeemedKins(address player) public view returns (uint256[] memory, string[] memory) {
        uint256[] memory redeemedIds = redeemedKinsClasses[player];
        string[] memory redeemedNames = new string[](redeemedIds.length);

        for (uint256 i = 0; i < redeemedIds.length; i++) {
            uint256 kinId = redeemedIds[i];
            redeemedNames[i] = kinsClasses[kinId].name;
        }

        return (redeemedIds, redeemedNames);
    }
}
