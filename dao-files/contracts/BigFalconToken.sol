// Contract based on: https://docs.openzeppelin.com/contracts/4.x/governance
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract BigFalconToken is ERC20, ERC20Permit, ERC20Votes {
    constructor() ERC20("BigFalconToken", "BFT") ERC20Permit("BigFalconToken") {
        _mint(msg.sender, 2500 * 10 ** decimals());
        _mint(
            0xD02C2c6720089430cBbec8725C289BA907dab660,
            2000 * 10 ** decimals()
        );
        _mint(
            0xA1899fE0535a7E6f9E42623fEc7bFc9520b98b45,
            1000 * 10 ** decimals()
        );
    }

    // The functions below are overrides required by Solidity.

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._mint(to, amount);
    }

    function _burn(
        address account,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._burn(account, amount);
    }
}
