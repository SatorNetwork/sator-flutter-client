import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/last_seen.dart';

class LastSeenModel extends LastSeen implements ToJsonInterface {
  const LastSeenModel(DateTime? timestamp)
      : super(timestamp);

  factory LastSeenModel.fromJson(Map json) => LastSeenModel(
    DateTime.tryParse(json['timestamp'] == null ? '' : json['timestamp']),
  );

  @override
  Map toJson() => {
    'timestamp': timestamp!.toIso8601String(),
  };
}
