import 'package:satorio/data/model/qr/qr_payload_show_model.dart';
import 'package:satorio/data/model/qr/qr_payload_wallet_send_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr/qr_data.dart';

class QrDataShowModel extends QrDataShow implements ToJsonInterface {
  QrDataShowModel(QrPayloadShowModel payload) : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class QrDataWalletModel extends QrDataWalletSend implements ToJsonInterface {
  QrDataWalletModel(QrPayloadWalletSendModel payload) : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class QrDataModelFactory {
  static QrData createQrData(Map json) {
    String type = json['type'];
    Map payloadJson = json['data'];
    switch (type) {
      case QrType.show:
        QrPayloadShowModel payload = QrPayloadShowModel.fromJson(payloadJson);
        if (payload.code.isEmpty)
          throw FormatException('unsupported type $type for QrData');
        else
          return QrDataShowModel(payload);
      case QrType.walletSend:
        QrPayloadWalletSendModel payload =
            QrPayloadWalletSendModel.fromJson(payloadJson);
        if (payload.walletAddress.isEmpty)
          throw FormatException('unsupported type $type for QrData');
        else
          return QrDataWalletModel(payload);
      default:
        throw FormatException('unsupported type $type for QrData');
    }
  }
}
