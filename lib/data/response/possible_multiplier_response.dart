import 'package:satorio/util/extension.dart';

class PossibleMultiplierResponse {
  final double possibleMultiplier;

  PossibleMultiplierResponse(this.possibleMultiplier);

  factory PossibleMultiplierResponse.fromJson(Map json) => PossibleMultiplierResponse(
        json.parseValueAsDouble('possibleMultiplier'),
      );
}
