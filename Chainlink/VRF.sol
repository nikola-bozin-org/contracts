//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

//When deployed, this contract address must be added to VRF Subscription @chainlink website as a consumer. Website: vrf.chain.link/goerli
//Can also be other network like "mainnet"
//Minimum number of requestConfirmations is 3
//If number is not updated to new value, check weather transaction on chainlink VRF Subscription is Pending. 
contract VRF is VRFConsumerBaseV2{
    
    VRFCoordinatorV2Interface immutable vrfCoordinator;
    bytes32 immutable keyHash; 
    uint256 private currentMaximumNumber=1;
    uint256 public randomNumber;

    constructor(address vrfCoordinatorAddress,bytes32 _keyHash) VRFConsumerBaseV2(vrfCoordinatorAddress) {
        vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorAddress);
        keyHash=_keyHash;
    }
    function fulfillRandomWords(uint256 requestId,uint256[] memory randomWords) internal override{
        randomNumber = randomWords[0]%currentMaximumNumber;
    } 
    function requstRandom(uint256 maximumValue,uint64 subscriptionId,uint16 requestConfirmations,uint32 callbackGasLimit) external {
        currentMaximumNumber = maximumValue;
        vrfCoordinator.requestRandomWords(keyHash,subscriptionId,requestConfirmations,callbackGasLimit,1);
    }
}