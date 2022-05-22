import 'package:satorio/data/datasource/solana_data_source.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

class SolanaDataSourceImpl implements SolanaDataSource {
  static const String _urlDevNet = 'https://api.devnet.solana.com';
  static const String _urlTestNet = 'https://api.testnet.solana.com';

  static const String _tokenDev =
      'FBDfbe7CFXHHNzDpNBYf4Evcg5GKrThYNjk4wP2xwjwA';
  static const String _tokenProd =
      '2HeykdKjzHKGm2LKHw8pDYwjKPiFEoXAz74dirhUgQvq';

  // static const String _wallet = 'kNiKFPho1eoCpR7DSx7yzebZ3v9oT6fYwM3ww8fv4eh';
  static const String _wallet = 'EBAUihTAwhG2pSuA1K2qJwmAh9LRxAa4Q5uhg3C1Yc9Q';

  late final SolanaClient _solanaClient;

  SolanaDataSourceImpl() {
    _solanaClientTmp();
    _rpcClientTmp();
  }

  void _solanaClientTmp() {
    print('SOLANA _solanaClientTmp');
    _solanaClient = SolanaClient(
      rpcUrl: Uri.parse(_urlDevNet),
      websocketUrl: Uri.parse(_urlDevNet),
      timeout: Duration(seconds: 30),
    );
  }

  void _rpcClientTmp() async {
    print('SOLANA _rpcClientTmp');

    // final pubKey = _wallet;

    final Account? _accountInfo =
        await _solanaClient.rpcClient.getAccountInfo(_wallet);
    // .then((value) => print('SOLANA getAccountInfo $value'))
    // .onError(
    //   (Exception error, stackTrace) =>
    //       print('SOLANA getAccountInfo ${error.toString()}'),
    // );
    print(
        'SOLANA getAccountInfo ${_accountInfo?.lamports} ${_accountInfo?.data}');

    _solanaClient.rpcClient
        .getBalance(_wallet)
        .then((value) => print('SOLANA getBalance $value'))
        .onError(
          (Exception error, stackTrace) =>
              print('SOLANA getBalance ${error.toString()}'),
        );

    // _solanaClient.rpcClient
    //     .getProgramAccounts(pubKey, encoding: Encoding.base58)
    //     .then((value) => print('SOLANA getProgramAccounts $value'))
    //     .onError(
    //       (Exception error, stackTrace) =>
    //           print('SOLANA getProgramAccounts ${error.toString()}'),
    //     );

    // _solanaClient.rpcClient
    //     .getSignaturesForAddress(pubKey)
    //     .then((List<TransactionSignatureInformation> value) =>
    //         print('SOLANA getSignaturesForAddress ${value.length}'))
    //     .onError(
    //       (Exception error, stackTrace) =>
    //           print('SOLANA getSignaturesForAddress ${error.toString()}'),
    //     );

    // _solanaClient.rpcClient
    //     .getStakeActivation(pubKey)
    //     .then((value) => print('SOLANA getStakeActivation $value'))
    //     .onError(
    //       (Exception error, stackTrace) =>
    //           print('SOLANA getStakeActivation ${error.toString()}'),
    //     );

    final ProgramAccount? tokenWallet =
        await _solanaClient.getAssociatedTokenAccount(
      owner: Ed25519HDPublicKey.fromBase58(_wallet),
      mint: Ed25519HDPublicKey.fromBase58(_tokenDev),
    );
    // .then((value) => print('SOLANA getAssociatedTokenAccount $value'))
    // .onError(
    //   (Exception error, stackTrace) =>
    //       print('SOLANA getAssociatedTokenAccount ${error.toString()}'),
    // );

    final TokenAmount _tokenAmount = await _solanaClient.rpcClient
        .getTokenAccountBalance(tokenWallet?.pubkey ?? '');
    // .then((value) => print('SOLANA getTokenAccountBalance $value'))
    // .onError(
    //   (Exception error, stackTrace) =>
    //       print('SOLANA getTokenAccountBalance ${error.toString()}'),
    // );
    print(
        'SOLANA getTokenAccountBalance ${_tokenAmount.amount} ${_tokenAmount.decimals} ${_tokenAmount.uiAmountString}');

    // _solanaClient.rpcClient
    //     .getTokenLargestAccounts(pubKey)
    //     .then((value) => print('SOLANA getTokenLargestAccounts $value'))
    //     .onError(
    //       (Exception error, stackTrace) =>
    //           print('SOLANA getTokenLargestAccounts ${error.toString()}'),
    //     );

    final Iterable<TransactionDetails> _transactions = await _solanaClient
        .rpcClient
        .getTransactionsList(Ed25519HDPublicKey.fromBase58(_wallet));
    print('SOLANA getTransactionsList ${_transactions.length}');
    _transactions.forEach((transaction) {
      print('${(transaction.transaction.message as ParsedMessage).instructions}');
    });
  }

  @override
  Future<void> balanceSOL(String solanaAccountAddress) {
    return Future.value();
  }

  @override
  Future<void> balanceSAO(String solanaAccountAddress) {
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
