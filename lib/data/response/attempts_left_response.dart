import 'package:satorio/util/extension.dart';

class AttemptsLeftResponse {
  final int attemptsLeft;

  AttemptsLeftResponse(this.attemptsLeft);

  factory AttemptsLeftResponse.fromJson(Map json) => AttemptsLeftResponse(
        json.parseValueAsInt('attempts_left'),
      );
}
