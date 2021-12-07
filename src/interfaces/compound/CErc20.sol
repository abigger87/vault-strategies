// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.10;

import "./CToken.sol";

/**
 * @title Compound's CErc20 Contract
 * @notice CTokens which wrap an EIP-20 underlying
 * @author Compound
 */
interface CErc20 is CToken {
    function mint(uint mintAmount) external returns (uint);
    function underlying() external view returns (address);
    function liquidateBorrow(address borrower, uint repayAmount, CToken cTokenCollateral) external returns (uint);
}