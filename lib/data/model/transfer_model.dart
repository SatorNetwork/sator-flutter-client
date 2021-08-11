import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/transfer.dart';

class TransferModel extends Transfer implements ToJsonInterface {
  const TransferModel(
    String assetName,
    double amount,
    double fee,
    String recipientAddress,
    String senderWalletId,
    String txHash,
  ) : super(
          assetName,
          amount,
          fee,
          recipientAddress,
          senderWalletId,
          txHash,
        );

  factory TransferModel.fromJson(Map json) => TransferModel(
        json['asset_name'] == null ? '' : json['asset_name'],
        json['amount'] == null
            ? 0.0
            : (json['amount'] is int
                ? (json['amount'] as int).toDouble()
                : json['amount']),
        json['fee'] == null
            ? 0.0
            : (json['fee'] is int
                ? (json['fee'] as int).toDouble()
                : json['fee']),
        json['recipient_address'] == null ? '' : json['recipient_address'],
        json['sender_wallet_id'] == null ? '' : json['sender_wallet_id'],
        json['tx_hash'] == null ? '' : json['tx_hash'],
      );

  @override
  Map toJson() => {
        'asset_name': assetName,
        'amount': amount,
        'fee': fee,
        'recipient_address': recipientAddress,
        'sender_wallet_id': senderWalletId,
        'tx_hash': txHash,
      };
}
