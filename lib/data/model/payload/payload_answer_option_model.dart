import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/util/extension.dart';

class PayloadAnswerOptionModel extends PayloadAnswerOption
    implements ToJsonInterface {
  const PayloadAnswerOptionModel(
    String answerId,
    String answerText,
  ) : super(
          answerId,
          answerText,
        );

  factory PayloadAnswerOptionModel.fromJson(Map json) =>
      PayloadAnswerOptionModel(
        json.parseValueAsString('answer_id'),
        json.parseValueAsString('answer_text'),
      );

  @override
  Map toJson() => {
        'answer_id': answerId,
        'answer_text': answerText,
      };
}
