abstract class SolanaDataSource {
  Future<void> balanceSOL(String solanaAccountAddress);

  Future<void> balanceSAO(String solanaAccountAddress);

  Future<void> transactionsATA();

  Future<void> nftList();
}
