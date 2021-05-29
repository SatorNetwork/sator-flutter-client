import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';

class PayloadQuestion extends Payload {
  final String questionId;
  final String questionText;
  final int timeForAnswer;
  final int totalQuestions;
  final int questionNumber;
  final List<PayloadAnswerOption> answerOptions;

  const PayloadQuestion(
    this.questionId,
    this.questionText,
    this.timeForAnswer,
    this.totalQuestions,
    this.questionNumber,
    this.answerOptions,
  );
}
