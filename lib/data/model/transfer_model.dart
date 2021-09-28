import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/util/extension.dart';

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
        json.parseValueAsString('asset_name'),
        json.parseValueAsDouble('amount'),
        json.parseValueAsDouble('fee'),
        json.parseValueAsString('recipient_address'),
        json.parseValueAsString('sender_wallet_id'),
        json.parseValueAsString('tx_hash'),
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
