import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadAnswer extends Payload {
  final String questionId;
  final String answerId;

  const PayloadAnswer(
    this.questionId,
    this.answerId,
  );
}
