abstract class SolanaDataSource {
  Future<void> balanceSOL();

  Future<void> balanceSAO();

  Future<void> transactionsATA();

  Future<void> nftList();
}
