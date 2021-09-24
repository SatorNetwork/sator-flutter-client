import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/util/extension.dart';

class TransactionModel extends Transaction implements ToJsonInterface {
  const TransactionModel(
    String id,
    String walletId,
    String txHash,
    double amount,
    DateTime? createdAt,
  ) : super(
          id,
          walletId,
          txHash,
          amount,
          createdAt,
        );

  factory TransactionModel.fromJson(Map json) => TransactionModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('wallet_id'),
        json.parseValueAsString('tx_hash'),
        json.parseValueAsDouble('amount'),
        json.tryParseValueAsDateTime('created_at'),
      );

  @override
  Map toJson() => {
        'id': id,
        'wallet_id': walletId,
        'tx_hash': txHash,
        'amount': amount,
        'created_at': createdAt?.toIso8601String() ?? '',
      };
}
