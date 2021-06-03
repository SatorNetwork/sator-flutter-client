import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_answer.dart';

class PayloadAnswerModel extends PayloadAnswer implements ToJsonInterface {
  const PayloadAnswerModel(String questionId, String answerId)
      : super(questionId, answerId);

  factory PayloadAnswerModel.fromJson(Map json) => PayloadAnswerModel(
        json['question_id'] == null ? '' : json['question_id'],
        json['answer_id'] == null ? '' : json['answer_id'],
      );

  @override
  Map toJson() => {
        'question_id': questionId,
        'answer_id': answerId,
      };
}
