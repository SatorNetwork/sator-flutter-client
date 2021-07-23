class Transaction {
  final String id;
  final String walletId;
  final String txHash;
  final double amount;
  final DateTime? createdAt;

  const Transaction(
    this.id,
    this.walletId,
    this.txHash,
    this.amount,
    this.createdAt,
  );
}
