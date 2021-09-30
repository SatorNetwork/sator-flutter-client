import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_answer.dart';
import 'package:satorio/util/extension.dart';

class PayloadAnswerModel extends PayloadAnswer implements ToJsonInterface {
  const PayloadAnswerModel(
    String questionId,
    String answerId,
  ) : super(
          questionId,
          answerId,
        );

  factory PayloadAnswerModel.fromJson(Map json) => PayloadAnswerModel(
        json.parseValueAsString('question_id'),
        json.parseValueAsString('answer_id'),
      );

  @override
  Map toJson() => {
        'question_id': questionId,
        'answer_id': answerId,
      };
}
