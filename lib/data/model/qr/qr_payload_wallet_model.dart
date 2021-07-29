import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr/qr_wallet_pyaload.dart';

class QrPayLoadWalletModel extends QrWalletPayload implements ToJsonInterface {
  const QrPayLoadWalletModel(String id)
      : super(id);

  factory QrPayLoadWalletModel.fromJson(Map json) => QrPayLoadWalletModel(
        json['id'] == null ? '' : json['id']
      );

  @override
  Map toJson() => {
        'id': id
      };
}
