import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/message.dart';

class MessageModel extends Message implements ToJsonInterface {
  const MessageModel(String text, String fromUserId, String fromUserName,  DateTime? createdAt)
      : super(text, fromUserId, fromUserName, createdAt);

  factory MessageModel.fromJson(Map json) => MessageModel(
    json['text'] == null ? '' : json['text'],
    json['fromUserId'] == null ? '' : json['fromUserId'],
    json['fromUserName'] == null ? '' : json['fromUserName'],
    DateTime.tryParse(json['createdAt'] == null ? '' : json['createdAt']),
  );

  @override
  Map toJson() => {
    'text': text,
    'fromUserId': fromUserId,
    'fromUserName': fromUserName,
    'createdAt': createdAt!.toIso8601String(),
  };
}
