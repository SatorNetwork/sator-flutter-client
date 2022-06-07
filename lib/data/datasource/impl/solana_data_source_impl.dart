import 'package:satorio/data/datasource/firebase_data_source.dart';
import 'package:satorio/data/datasource/solana_data_source.dart';
import 'package:satorio/data/model/transaction_model.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

class SolanaDataSourceImpl implements SolanaDataSource {
  static const int _trxCount = 30;

  late final String _token;
  late final String _url;

  final FirebaseDataSource _firebaseDataSource;
  late final SolanaClient _solanaClient;

  SolanaDataSourceImpl(this._firebaseDataSource);

  Future<void> init() async {
    _token = await _firebaseDataSource.solanaToken();
    _url = await _firebaseDataSource.solanaClusterUrl();

    _solanaClient = SolanaClient(
      rpcUrl: Uri.parse(_url),
      websocketUrl: Uri.parse(_url),
      timeout: Duration(seconds: 30),
    );
  }

  @override
  Future<void> balanceSOL(String solanaAccountAddress) async {
    final int _balance =
        await _solanaClient.rpcClient.getBalance(solanaAccountAddress);
    //
    // print('SOLANA getBalance $_balance');
  }

  @override
  Future<void> balanceSAO(String solanaAccountAddress) async {
    final ProgramAccount? tokenWallet =
        await _tokenProgramAccount(solanaAccountAddress);

    final TokenAmount _tokenAmount = await _solanaClient.rpcClient
        .getTokenAccountBalance(tokenWallet?.pubkey ?? '');

    // print(
    //     'SOLANA getTokenAccountBalance ${_tokenAmount.amount} ${_tokenAmount.decimals} ${_tokenAmount.uiAmountString}');
  }

  @override
  Future<List<TransactionModel>> transactionsATA(
      String walletId, String solanaAccountAddress) async {
    final List<TransactionModel> result = [];

    final Iterable<TransactionDetails> _transactions =
        await _solanaClient.rpcClient.getTransactionsList(
      Ed25519HDPublicKey.fromBase58(solanaAccountAddress),
      commitment: Commitment.finalized,
      limit: _trxCount,
    );

    final ProgramAccount? tokenAccount =
        await _tokenProgramAccount(solanaAccountAddress);

    _transactions.forEach((transaction) {
      final DateTime dt = DateTime.fromMillisecondsSinceEpoch(
          (transaction.blockTime ?? 0) * 1000);

      final String? txHash = transaction.transaction.signatures.isNotEmpty
          ? transaction.transaction.signatures[0]
          : null;
      double? amount;

      (transaction.transaction.message as ParsedMessage)
          .instructions
          .forEach((instruction) {
        if (instruction is ParsedInstructionSplToken) {
          final ParsedSplTokenInstruction parsed = instruction.parsed;
          if (parsed is ParsedSplTokenTransferInstruction) {
            // ParsedSplTokenTransferInstruction
          } else if (parsed is ParsedSplTokenTransferCheckedInstruction) {
            final double? parsedAmount =
                double.tryParse(parsed.info.tokenAmount.uiAmountString ?? '');

            if (parsedAmount != null) {
              amount = parsed.info.source == tokenAccount?.pubkey
                  ? -parsedAmount
                  : parsedAmount;
            }
          } else if (parsed is ParsedSplTokenGenericInstruction) {
            // ParsedSplTokenGenericInstruction
          }
        } else if (instruction is ParsedInstructionSystem) {
          final ParsedSystemInstruction parsed = instruction.parsed;
          if (parsed is ParsedSystemTransferInstruction) {
            // ParsedSystemTransferInstruction
          } else if (parsed is ParsedSystemTransferCheckedInstruction) {
            // ParsedSystemTransferCheckedInstruction
          }
        } else if (instruction is ParsedInstructionMemo) {
          // ParsedInstructionMemo
        }
      });

      if (txHash != null && amount != null) {
        result.add(TransactionModel(
          txHash,
          walletId,
          txHash,
          amount!,
          dt,
        ));
      }
    });

    return result;
  }

  @override
  Future<void> nftList() async {}

  Future<ProgramAccount?> _tokenProgramAccount(String solanaAccountAddress) {
    return _solanaClient.getAssociatedTokenAccount(
      owner: Ed25519HDPublicKey.fromBase58(solanaAccountAddress),
      mint: Ed25519HDPublicKey.fromBase58(_token),
    );
  }
}
