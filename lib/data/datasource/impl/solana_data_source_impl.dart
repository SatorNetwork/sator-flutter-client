import 'package:satorio/data/datasource/solana_data_source.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

class SolanaDataSourceImpl implements SolanaDataSource {
  static const String _urlDevNet = 'https://api.devnet.solana.com';
  static const String _urlTestNet = 'https://api.testnet.solana.com';

  static const String _dev = 'FBDfbe7CFXHHNzDpNBYf4Evcg5GKrThYNjk4wP2xwjwA';
  static const String _prod = '2HeykdKjzHKGm2LKHw8pDYwjKPiFEoXAz74dirhUgQvq';

  late final RpcClient _rpcClient;

  SolanaDataSourceImpl() {
    print('SolanaDataSourceImpl');
    _rpcClient = RpcClient(_urlDevNet, timeout: const Duration(seconds: 30));

    _rpcClient.getAccountInfo(_dev).then((value) => print('SOLANA getAccountInfo $value'));

    _rpcClient.getBalance(_dev).then((value) => print('SOLANA getBalance $value'));

    _rpcClient.getProgramAccounts(_dev, encoding: Encoding.base58).then((value) => print('SOLANA getProgramAccounts $value'));

    _rpcClient.getSignaturesForAddress(_dev).then((value) => print('SOLANA getSignaturesForAddress $value'));

    _rpcClient.getStakeActivation(_dev).then((value) => print('SOLANA getStakeActivation $value'));

    _rpcClient.getTokenAccountBalance(_dev).then((value) => print('SOLANA getTokenAccountBalance $value'));

    _rpcClient.getTokenLargestAccounts(_dev).then((value) => print('SOLANA getTokenLargestAccounts $value'));
  }

  @override
  Future<void> balanceSOL() {

    return Future.value();
  }

  @override
  Future<void> balanceSAO() {
    return Future.value();
  }

  @override
  Future<void> transactionsATA() {
    return Future.value();
  }

  @override
  Future<void> nftList() {
    return Future.value();
  }

}
