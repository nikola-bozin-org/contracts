//SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract IDGenerator{
    uint256 public id_nonce;
    constructor(){
        id_nonce =0;
    }
    function _generateID() internal returns(bytes32){
        id_nonce++;
        return keccak256(abi.encode(address(this),id_nonce));
    }
}