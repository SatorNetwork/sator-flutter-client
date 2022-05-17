import 'package:satorio/data/model/puzzle/position_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/puzzle/tile.dart';
import 'package:satorio/util/extension.dart';

class TileModel extends Tile implements ToJsonInterface {
  const TileModel(
    int value,
    PositionModel currentPosition,
    bool isWhitespace,
  ) : super(
          value,
          currentPosition,
          isWhitespace,
        );

  factory TileModel.fromJson(Map json) => TileModel(
        json.parseValueAsInt('value'),
        json['current_position'] == null
            ? PositionModel(0, 0)
            : PositionModel.fromJson(json['current_position']),
        json.parseValueAsBool('is_whitespace'),
      );

  @override
  Map toJson() => {
        'value': value,
        'current_position': (currentPosition as ToJsonInterface).toJson(),
        'is_whitespace': isWhitespace,
      };
}
