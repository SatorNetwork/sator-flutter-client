import 'package:satorio/data/model/to_json_interface.dart';

class PuzzleResultRequest implements ToJsonInterface {
  final int result;
  final int stepsTaken;

  const PuzzleResultRequest(
    this.result,
    this.stepsTaken,
  );

  @override
  Map toJson() => {
        'result': result,
        'steps_taken': stepsTaken,
      };
}
