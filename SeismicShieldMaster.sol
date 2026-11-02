// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BridgeEscrow {
    uint256 public escrowNonce;
    mapping(uint256 => bytes32) public lockedReceipts;

    event ReceiptLocked(uint256 indexed nonce, address indexed sender, bytes32 receiptHash);

    function lockCrosschainReceipt(uint256 _dstChainId) external {
        escrowNonce += 1;
        bytes32 receipt = keccak256(abi.encodePacked(msg.sender, _dstChainId, escrowNonce));
        lockedReceipts[escrowNonce] = receipt;
        emit ReceiptLocked(escrowNonce, msg.sender, receipt);
    }
}
