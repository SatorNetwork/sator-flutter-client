import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_answer.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';

class SocketMessage<T extends Payload> {
  final String type;
  final T payload;

  const SocketMessage(this.type, this.payload);
}

class Type {
  static const player_connected = 'player_connected';
  static const player_disconnected = 'player_disconnected';
  static const countdown = 'countdown';
  static const question = 'question';
  static const question_result = 'question_result';
  static const challenge_result = 'challenge_result';
  static const answer = 'answer';
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