import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';

class PayloadCountdownModel extends PayloadCountdown
    implements ToJsonInterface {
  const PayloadCountdownModel(int countdown) : super(countdown);

  factory PayloadCountdownModel.fromJson(Map json) => PayloadCountdownModel(
        json['countdown'] == null ? 0 : json['countdown'],
      );

  @override
  Map toJson() => {
        'countdown': countdown,
      };
}
