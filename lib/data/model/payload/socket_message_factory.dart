import 'package:satorio/data/model/payload/payload_answer_model.dart';
import 'package:satorio/data/model/payload/payload_challenge_result_model.dart';
import 'package:satorio/data/model/payload/payload_countdown_model.dart';
import 'package:satorio/data/model/payload/payload_question_model.dart';
import 'package:satorio/data/model/payload/payload_question_result_model.dart';
import 'package:satorio/data/model/payload/payload_time_out_model.dart';
import 'package:satorio/data/model/payload/payload_user_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/socket_message.dart';

class SocketMessagePlayerConnectedModel extends SocketMessagePlayerConnected
    implements ToJsonInterface {
  SocketMessagePlayerConnectedModel(PayloadUserModel payload) : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessagePlayerDisconnectedModel
    extends SocketMessagePlayerDisconnected implements ToJsonInterface {
  SocketMessagePlayerDisconnectedModel(PayloadUserModel payload)
      : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessageCountdownModel extends SocketMessageCountdown
    implements ToJsonInterface {
  SocketMessageCountdownModel(PayloadCountdownModel payload) : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessageQuestionModel extends SocketMessageQuestion
    implements ToJsonInterface {
  SocketMessageQuestionModel(PayloadQuestionModel payload) : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessageQuestionResultModel extends SocketMessageQuestionResult
    implements ToJsonInterface {
  SocketMessageQuestionResultModel(PayloadQuestionResultModel payload)
      : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessageChallengeResultModel extends SocketMessageChallengeResult
    implements ToJsonInterface {
  SocketMessageChallengeResultModel(PayloadChallengeResultModel payload)
      : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessageAnswerModel extends SocketMessageAnswer
    implements ToJsonInterface {
  SocketMessageAnswerModel(PayloadAnswerModel payload) : super(payload);

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
      };
}

class SocketMessageModelFactory {
  static SocketMessage createSocketMessage(Map json) {
    String type = json['type'];
    Map payloadJson = json['payload'];
    switch (type) {
      case Type.player_connected:
        return SocketMessagePlayerConnectedModel(
          PayloadUserModel.fromJson(payloadJson),
        );
      case Type.player_disconnected:
        return SocketMessagePlayerDisconnectedModel(
          PayloadUserModel.fromJson(payloadJson),
        );
      case Type.countdown:
        return SocketMessageCountdownModel(
          PayloadCountdownModel.fromJson(payloadJson),
        );
      case Type.question:
        return SocketMessageQuestionModel(
          PayloadQuestionModel.fromJson(payloadJson),
        );
      case Type.question_result:
        return SocketMessageQuestionResultModel(
          PayloadQuestionResultModel.fromJson(payloadJson),
        );
      case Type.challenge_result:
        return SocketMessageChallengeResultModel(
          PayloadChallengeResultModel.fromJson(payloadJson),
        );
      case Type.answer:
        return SocketMessageAnswerModel(
          PayloadAnswerModel.fromJson(payloadJson),
        );
      case Type.time_out:
        return SocketMessageTimeOut(
          PayloadTimeOutModel.fromJson(payloadJson),
        );
      default:
        throw FormatException('unsupported type $type for SocketMessage');
    }
  }
}
