import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/temp.dart';

class TempModel extends Temp implements ToJsonInterface {
  const TempModel(String data) : super(data);

  factory TempModel.fromJson(Map json) => TempModel(json['data'] as String);

  @override
  Map toJson() => <String, dynamic>{'data': this.data};
}
