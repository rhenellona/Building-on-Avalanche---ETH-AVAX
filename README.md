# Degen Token (ERC-20): Unlocking the Future of Gaming
Supposedly, we must be able to create ERC20 token and deploy it on the Avalanche network for Degen Gaming. This smart contract has the different functions: mint, transfer, redeem, check balance, and burn tokens. But due to the problem regarding the expired api key, I wasn't
able to deploy it on avalanche fuji testnet and verify my contract using snowtrace, and so we were advised to just show the different functions needed in this contract. 

## Description

Allows minting, burning, redeeming, checking balance and transferring tokens between addresses. 

## Usage/Features

1. Allows minting tokens, through the mint function.
2. Allows token holders to burn their own tokens, through the burn function which effectively reduce the token supply.
3. Allows transferring tokens to other addresses. 
4. Allows checking total supply of other addresses.
5. Allows to check amount of Kins Class.
6. Allows adding redeemable items and check players redeemed items.

### What to do before executing program?

* Import ERC20 token.
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; //
  
### Executing Program 

1. Use any solidity compiler, I used remix IDE.
2. Go to solidity compiler, and compile file.
3. On the deploy & run transactions panel, assign the total supply then click deploy.
4. On the deployed contracts panel, you can try to mint, burn, check balance, redeem, and transfer amounts to different addresses.

Feel free to mint, burn, and transfer amounts!

## Authors

Rhene F. Llona
email : 8213812@ntc.edu.ph


## License

Unlicensed.
