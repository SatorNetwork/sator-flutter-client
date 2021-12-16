import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_answer.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';
import 'package:satorio/domain/entities/payload/payload_empty.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/domain/entities/payload/payload_time_out.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';

class SocketMessage<T extends Payload> {
  final String type;
  final T payload;

  const SocketMessage(this.type, this.payload);
}

class Type {
  static const player_connected = 'player_is_joined';
  static const countdown = 'countdown';
  static const question = 'question';
  static const answer = 'answer';
  static const question_result = 'answer_reply';
  static const challenge_result = 'winners_table';
  static const player_is_active = 'player_is_active';
  static const player_disconnected = 'player_is_disconnected';

  static const time_out = 'time_out';

  static String fromInt(int typeInt) {
    switch (typeInt) {
      case 0:
        return player_connected;
      case 1:
        return countdown;
      case 2:
        return question;
      case 3:
        return answer;
      case 4:
        return question_result;
      case 5:
        return challenge_result;
      case 6:
        return player_is_active;
      case 7:
        return player_disconnected;
      default:
        return '';
    }
  }
}

class SocketMessagePlayerConnected extends SocketMessage<PayloadUser> {
  SocketMessagePlayerConnected(PayloadUser payload)
      : super(Type.player_connected, payload);
}

class SocketMessagePlayerDisconnected extends SocketMessage<PayloadUser> {
  SocketMessagePlayerDisconnected(PayloadUser payload)
      : super(Type.player_disconnected, payload);
}

class SocketMessageCountdown extends SocketMessage<PayloadCountdown> {
  SocketMessageCountdown(PayloadCountdown payload)
      : super(Type.countdown, payload);
}

class SocketMessageQuestion extends SocketMessage<PayloadQuestion> {
  SocketMessageQuestion(PayloadQuestion payload)
      : super(Type.question, payload);
}

class SocketMessageQuestionResult extends SocketMessage<PayloadQuestionResult> {
  SocketMessageQuestionResult(PayloadQuestionResult payload)
      : super(Type.question_result, payload);
}

class SocketMessageChallengeResult
    extends SocketMessage<PayloadChallengeResult> {
  SocketMessageChallengeResult(PayloadChallengeResult payload)
      : super(Type.challenge_result, payload);
}

class SocketMessageAnswer extends SocketMessage<PayloadAnswer> {
  SocketMessageAnswer(PayloadAnswer payload) : super(Type.answer, payload);
}

class SocketMessageTimeOut extends SocketMessage<PayloadTimeOut> {
  SocketMessageTimeOut(PayloadTimeOut payload) : super(Type.time_out, payload);
}

class SocketMessagePlayerIsActive extends SocketMessage<PayloadEmpty> {
  SocketMessagePlayerIsActive(PayloadEmpty payload)
      : super(Type.player_is_active, payload);
}
