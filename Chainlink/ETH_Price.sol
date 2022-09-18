//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ETH_Price{

    AggregatorV3Interface aV3i;

    constructor(address aV3i_Address){
        aV3i = AggregatorV3Interface(aV3i_Address);
    }
    function getPrice() public view returns(uint256){
        (,int256 price,,,) = aV3i.latestRoundData();
        return uint256(price);
    }
    function getFullPrice() public view returns(uint256){
        return getPrice()*1e10;
    }
    function getVersion() public view returns(uint256){
        return aV3i.version();
    }
    function getDecimals() public view returns(uint256){
        return aV3i.decimals();
    }
}