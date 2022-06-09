import 'package:satorio/data/model/transaction_model.dart';

abstract class SolanaDataSource {
  Future<void> init();

  Future<void> balanceSOL(String solanaAccountAddress);

  Future<double?> balanceSAO(String solanaAccountAddress);

  Future<List<TransactionModel>> transactionsATA(
    String walletId,
    String solanaAccountAddress,
  );

  Future<void> nftList();
}
