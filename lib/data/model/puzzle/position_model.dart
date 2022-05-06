import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/puzzle/position.dart';
import 'package:satorio/util/extension.dart';

class PositionModel extends Position implements ToJsonInterface {
  const PositionModel(int x, int y) : super(x, y);

  factory PositionModel.fromJson(Map json) => PositionModel(
        json.parseValueAsInt('x'),
        json.parseValueAsInt('y'),
      );

  @override
  Map toJson() => {
        'x': x,
        'y': y,
      };
}
