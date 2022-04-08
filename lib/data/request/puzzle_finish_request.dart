import 'package:satorio/data/model/to_json_interface.dart';

class PuzzleFinishRequest implements ToJsonInterface {
  final int result;
  final int stepsTaken;

  const PuzzleFinishRequest(
    this.result,
    this.stepsTaken,
  );

  @override
  Map toJson() => {
        'result': result,
        'steps_taken': stepsTaken,
      };
}
