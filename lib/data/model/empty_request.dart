import 'package:satorio/data/model/to_json_interface.dart';

class EmptyRequest implements ToJsonInterface {
  @override
  Map toJson() => {};
}
