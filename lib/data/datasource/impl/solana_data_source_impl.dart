import 'package:satorio/data/datasource/solana_data_source.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

class SolanaDataSourceImpl implements SolanaDataSource {
  static const String _urlDevNet = 'https://api.devnet.solana.com';
  static const String _urlTestNet = 'https://api.testnet.solana.com';

  static const String _dev = 'FBDfbe7CFXHHNzDpNBYf4Evcg5GKrThYNjk4wP2xwjwA';
  static const String _prod = '2HeykdKjzHKGm2LKHw8pDYwjKPiFEoXAz74dirhUgQvq';

  late final SolanaClient _solanaClient;

  SolanaDataSourceImpl() {
    _solanaClientTmp();
    _rpcClientTmp();
  }

  void _rpcClientTmp() {
    print('SOLANA _rpcClientTmp');

    final pubKey = _dev;

    _solanaClient.rpcClient
        .getAccountInfo(pubKey)
        .then((value) => print('SOLANA getAccountInfo $value'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getAccountInfo ${error.toString()}'),
        );

    _solanaClient.rpcClient
        .getBalance(pubKey)
        .then((value) => print('SOLANA getBalance $value'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getBalance ${error.toString()}'),
        );

    _solanaClient.rpcClient
        .getProgramAccounts(pubKey, encoding: Encoding.base58)
        .then((value) => print('SOLANA getProgramAccounts $value'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getProgramAccounts ${error.toString()}'),
        );

    _solanaClient.rpcClient
        .getSignaturesForAddress(pubKey)
        .then((List<TransactionSignatureInformation> value) =>
            print('SOLANA getSignaturesForAddress ${value.length}'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getSignaturesForAddress ${error.toString()}'),
        );

    _solanaClient.rpcClient
        .getStakeActivation(pubKey)
        .then((value) => print('SOLANA getStakeActivation $value'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getStakeActivation ${error.toString()}'),
        );

    _solanaClient.rpcClient
        .getTokenAccountBalance(pubKey)
        .then((value) => print('SOLANA getTokenAccountBalance $value'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getTokenAccountBalance ${error.toString()}'),
        );

    // _rpcClient
    //     .getTokenLargestAccounts(pubKey)
    //     .then((value) => print('SOLANA getTokenLargestAccounts $value'))
    //     .onError(
    //       (Exception error, stackTrace) =>
    //           print('SOLANA getTokenLargestAccounts ${error.toString()}'),
    //     );
  }

  void _solanaClientTmp() {
    print('SOLANA _solanaClientTmp');
    _solanaClient = SolanaClient(
      rpcUrl: Uri.parse(_urlDevNet),
      websocketUrl: Uri.parse(_urlDevNet),
      timeout: Duration(seconds: 30),
    );
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
