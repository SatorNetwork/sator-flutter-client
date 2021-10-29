import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_time_out.dart';
import 'package:satorio/util/extension.dart';

class PayloadTimeOutModel extends PayloadTimeOut implements ToJsonInterface {
  const PayloadTimeOutModel(String message) : super(message);

  factory PayloadTimeOutModel.fromJson(Map json) => PayloadTimeOutModel(
        json.parseValueAsString('message'),
      );

  @override
  Map toJson() => {
        'message': message,
      };
}
