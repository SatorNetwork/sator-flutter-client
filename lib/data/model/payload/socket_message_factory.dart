import 'package:satorio/data/model/payload/payload_answer_model.dart';
import 'package:satorio/data/model/payload/payload_challenge_result_model.dart';
import 'package:satorio/data/model/payload/payload_countdown_model.dart';
import 'package:satorio/data/model/payload/payload_empty_model.dart';
import 'package:satorio/data/model/payload/payload_question_model.dart';
import 'package:satorio/data/model/payload/payload_question_result_model.dart';
import 'package:satorio/data/model/payload/payload_time_out_model.dart';
import 'package:satorio/data/model/payload/payload_user_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/socket_message.dart';
import 'package:satorio/util/extension.dart';

class SocketMessagePlayerConnectedModel extends SocketMessagePlayerConnected
    implements ToJsonInterface {
  SocketMessagePlayerConnectedModel(
    PayloadUserModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessagePlayerDisconnectedModel
    extends SocketMessagePlayerDisconnected implements ToJsonInterface {
  SocketMessagePlayerDisconnectedModel(
    PayloadUserModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageCountdownModel extends SocketMessageCountdown
    implements ToJsonInterface {
  SocketMessageCountdownModel(
    PayloadCountdownModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageQuestionModel extends SocketMessageQuestion
    implements ToJsonInterface {
  SocketMessageQuestionModel(
    PayloadQuestionModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageQuestionResultModel extends SocketMessageQuestionResult
    implements ToJsonInterface {
  SocketMessageQuestionResultModel(
    PayloadQuestionResultModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageChallengeResultModel extends SocketMessageChallengeResult
    implements ToJsonInterface {
  SocketMessageChallengeResultModel(
    PayloadChallengeResultModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageAnswerModel extends SocketMessageAnswer
    implements ToJsonInterface {
  SocketMessageAnswerModel(
    PayloadAnswerModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageTimeOutModel extends SocketMessageTimeOut
    implements ToJsonInterface {
  SocketMessageTimeOutModel(
    PayloadTimeOutModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessagePlayerIsActiveModel extends SocketMessagePlayerIsActive
    implements ToJsonInterface {
  SocketMessagePlayerIsActiveModel(
    PayloadEmptyModel payload,
    DateTime? date,
    int ttl,
  ) : super(
          payload,
          date,
          ttl,
        );

  @override
  Map toJson() => {
        'type': type,
        'payload': (payload as ToJsonInterface).toJson(),
        'date': date?.toIso8601String() ?? '',
        'ttl': ttl,
      };
}

class SocketMessageModelFactory {
  static SocketMessage createSocketMessage(Map json) {
    final String type = json['type'] == null
        ? ''
        : (json['type'] is int
            ? Type.fromInt(json['type'] as int)
            : json['type'] as String);
    final DateTime? date = json.tryParseValueAsDateTime('date');
    final int ttl = json.parseValueAsInt('ttl');
    final Map payloadJson = json['payload'];

    switch (type) {
      case Type.player_connected:
        return SocketMessagePlayerConnectedModel(
          PayloadUserModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.player_disconnected:
        return SocketMessagePlayerDisconnectedModel(
          PayloadUserModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.countdown:
        return SocketMessageCountdownModel(
          PayloadCountdownModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.question:
        return SocketMessageQuestionModel(
          PayloadQuestionModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.question_result:
        return SocketMessageQuestionResultModel(
          PayloadQuestionResultModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.challenge_result:
        return SocketMessageChallengeResultModel(
          PayloadChallengeResultModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.answer:
        return SocketMessageAnswerModel(
          PayloadAnswerModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.time_out:
        return SocketMessageTimeOutModel(
          PayloadTimeOutModel.fromJson(payloadJson),
          date,
          ttl,
        );
      case Type.player_is_active:
        return SocketMessagePlayerIsActiveModel(
          PayloadEmptyModel.fromJson(payloadJson),
          date,
          ttl,
        );
      default:
        throw FormatException('unsupported type $type for SocketMessage');
    }
  }
}
