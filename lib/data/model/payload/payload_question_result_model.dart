import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/util/extension.dart';

class PayloadQuestionResultModel extends PayloadQuestionResult
    implements ToJsonInterface {
  const PayloadQuestionResultModel(
    String questionId,
    bool result,
    int rate,
    String correctAnswerId,
    int questionsLeft,
    int additionalPts,
  ) : super(
          questionId,
          result,
          rate,
          correctAnswerId,
          questionsLeft,
          additionalPts,
        );

  factory PayloadQuestionResultModel.fromJson(Map json) =>
      PayloadQuestionResultModel(
        json.parseValueAsString('question_id'),
        json.parseValueAsBool('result'),
        json.parseValueAsInt('rate'),
        json.parseValueAsString('correct_answer_id'),
        json.parseValueAsInt('questions_left'),
        json.parseValueAsInt('additional_pts'),
      );

  @override
  Map toJson() => {
        'question_id': questionId,
        'result': result,
        'rate': rate,
        'correct_answer_id': correctAnswerId,
        'questions_left': questionsLeft,
        'additional_pts': additionalPts,
      };
}
