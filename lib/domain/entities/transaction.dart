class Transaction {
  final String txHash;
  final double amount;
  final DateTime? createdAt;

  const Transaction(this.txHash, this.amount, this.createdAt);
}
