import 'package:satorio/data/model/to_json_interface.dart';

class TapTileRequest implements ToJsonInterface {
  final int x;
  final int y;

  const TapTileRequest(this.x, this.y);

  @override
  Map toJson() => {
        'x': x,
        'y': y,
      };
}
