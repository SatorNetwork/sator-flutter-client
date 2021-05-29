import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadAnswerOption extends Payload {
  final String answerId;
  final String answerText;

  const PayloadAnswerOption(
    this.answerId,
    this.answerText,
  );
}
