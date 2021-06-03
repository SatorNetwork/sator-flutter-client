import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';

class PayloadQuestionResultModel extends PayloadQuestionResult
    implements ToJsonInterface {
  const PayloadQuestionResultModel(
    String questionId,
    bool result,
    int rate,
    String correctAnswerId,
    int questionsLeft,
    int additionalPts,
  ) : super(questionId, result, rate, correctAnswerId, questionsLeft,
            additionalPts);

  factory PayloadQuestionResultModel.fromJson(Map json) =>
      PayloadQuestionResultModel(
        json['question_id'] == null ? '' : json['question_id'],
        json['result'] == null ? false : json['result'],
        json['rate'] == null ? 0 : json['rate'],
        json['correctAnswerId'] == null ? '' : json['correctAnswerId'],
        json['questions_left'] == null ? 0 : json['questions_left'],
        json['additionalPts'] == null ? 0 : json['additionalPts'],
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
