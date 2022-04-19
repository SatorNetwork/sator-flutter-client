import 'package:satorio/data/model/payload/payload_answer_option_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/util/extension.dart';

class PayloadQuestionModel extends PayloadQuestion implements ToJsonInterface {
  const PayloadQuestionModel(
    String questionId,
    String questionText,
    int timeForAnswer,
    int totalQuestions,
    int questionNumber,
    List<PayloadAnswerOption> answerOptions,
  ) : super(
          questionId,
          questionText,
          timeForAnswer,
          totalQuestions,
          questionNumber,
          answerOptions,
        );

  factory PayloadQuestionModel.fromJson(Map json) => PayloadQuestionModel(
        json.parseValueAsString('question_id'),
        json.parseValueAsString('question_text'),
        json.parseValueAsInt('time_for_answer'),
        json.parseValueAsInt('total_questions'),
        json.parseValueAsInt('question_number'),
        (json['answer_options'] == null ||
                !(json['answer_options'] is Iterable))
            ? []
            : (json['answer_options'] as Iterable)
                .where((element) => element != null)
                .map((element) => PayloadAnswerOptionModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'question_id': questionId,
        'question_text': questionText,
        'time_for_answer': timeForAnswer,
        'total_questions': totalQuestions,
        'question_number': questionNumber,
        'answer_options': answerOptions
            .whereType<ToJsonInterface>()
            .map((element) => element.toJson())
            .toList(),
      };
}
