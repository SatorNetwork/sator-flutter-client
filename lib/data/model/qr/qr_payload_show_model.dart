import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr/qr_payload_show.dart';
import 'package:satorio/util/extension.dart';

class QrPayloadShowModel extends QrPayloadShow implements ToJsonInterface {
  const QrPayloadShowModel(String code) : super(code);

  factory QrPayloadShowModel.fromJson(Map json) => QrPayloadShowModel(
        json.parseValueAsString('code'),
      );

  @override
  Map toJson() => {
        'code': code,
      };
}
