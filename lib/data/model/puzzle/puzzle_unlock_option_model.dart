import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_unlock_option.dart';
import 'package:satorio/util/extension.dart';

class PuzzleUnlockOptionModel extends PuzzleUnlockOption
    implements ToJsonInterface {
  const PuzzleUnlockOptionModel(
    String id,
    double amount,
    int steps,
    bool isLocked,
  ) : super(
          id,
          amount,
          steps,
          isLocked,
        );

  factory PuzzleUnlockOptionModel.fromJson(Map json) => PuzzleUnlockOptionModel(
        json.parseValueAsString('id'),
        json.parseValueAsDouble('amount'),
        json.parseValueAsInt('steps'),
        json.parseValueAsBool('is_locked'),
      );

  @override
  Map toJson() => {
        'id': id,
        'amount': amount,
        'steps': steps,
      };
}
