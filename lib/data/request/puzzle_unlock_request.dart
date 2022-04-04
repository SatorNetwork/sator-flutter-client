import 'package:satorio/data/model/to_json_interface.dart';

class PuzzleUnlockRequest implements ToJsonInterface {
  final String unlockOption;

  const PuzzleUnlockRequest(this.unlockOption);

  @override
  Map toJson() => {
        'unlock_option': unlockOption,
      };
}
