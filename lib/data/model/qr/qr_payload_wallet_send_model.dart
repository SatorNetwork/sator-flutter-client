import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr/qr_payload_wallet_send.dart';
import 'package:satorio/util/extension.dart';

class QrPayloadWalletSendModel extends QrPayloadWalletSend
    implements ToJsonInterface {
  const QrPayloadWalletSendModel(String walletAddress) : super(walletAddress);

  factory QrPayloadWalletSendModel.fromJson(Map json) =>
      QrPayloadWalletSendModel(
        json.parseValueAsString('wallet_address'),
      );

  @override
  Map toJson() => {'wallet_address': walletAddress};
}
