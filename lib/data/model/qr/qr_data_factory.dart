import 'package:satorio/data/model/qr/qr_payload_show_model.dart';
import 'package:satorio/data/model/qr/qr_payload_wallet_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr/qr_data.dart';

class QrDataShowModel extends QrDataShow implements ToJsonInterface {
  QrDataShowModel(String qrId, QrPayLoadShowModel payload)
      : super(qrId, payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class QrDataWalletModel extends QrDataWallet implements ToJsonInterface {
  QrDataWalletModel(String qrId, QrPayLoadWalletModel payload)
      : super(qrId, payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class QrDataModelFactory {
  static QrData createQrData(Map json) {
    String qrId = json['code'];
    String type = json['type'];
    Map payloadJson = json['data'];
    switch (type) {
      case QrType.show:
        return QrDataShowModel(qrId, QrPayLoadShowModel.fromJson(payloadJson));
      case QrType.wallet:
        return QrDataWalletModel(qrId, QrPayLoadWalletModel.fromJson(payloadJson));
      default:
        throw FormatException('unsupported type $type for QrData');
    }
  }
}
