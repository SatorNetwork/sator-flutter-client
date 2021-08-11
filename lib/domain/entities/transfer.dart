class Transfer {
  final String assetName;
  final double amount;
  final double fee;
  final String recipientAddress;
  final String senderWalletId;
  final String txHash;

  const Transfer(
    this.assetName,
    this.amount,
    this.fee,
    this.recipientAddress,
    this.senderWalletId,
    this.txHash,
  );
}
