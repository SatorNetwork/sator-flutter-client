import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/nats_config.dart';

class NatsConfigModel extends NatsConfig implements ToJsonInterface {
  const NatsConfigModel(
    String baseQuizUrl,
    String baseQuizWsUrl,
    String receiveSubj,
    String sendSubj,
    String userId,
  ) : super(
          baseQuizUrl,
          baseQuizWsUrl,
          receiveSubj,
          sendSubj,
          userId,
        );

  factory NatsConfigModel.fromJson(Map json) => NatsConfigModel(
        json['base_quiz_url'] == null ? '' : json['base_quiz_url'],
        json['base_quiz_url'] == null ? '' : json['base_quiz_ws_url'],
        json['recv_message_subj'] == null ? '' : json['recv_message_subj'],
        json['send_message_subj'] == null ? '' : json['send_message_subj'],
        json['user_id'] == null ? '' : json['user_id'],
      );

  @override
  Map toJson() => {
        'base_quiz_url': baseQuizUrl,
        'recv_message_subj': receiveSubj,
        'send_message_subj': sendSubj,
        'user_id': userId,
      };
}
