import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadQuestionResult extends Payload {
  final String questionId;
  final bool result;
  final int rate;
  final String correctAnswerId;
  final int questionsLeft;
  final int additionalPts;

  const PayloadQuestionResult(
    this.questionId,
    this.result,
    this.rate,
    this.correctAnswerId,
    this.questionsLeft,
    this.additionalPts,
  );
}
