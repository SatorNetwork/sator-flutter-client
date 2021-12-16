import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_empty.dart';

class PayloadEmptyModel extends PayloadEmpty implements ToJsonInterface {
  const PayloadEmptyModel() : super();

  factory PayloadEmptyModel.fromJson(Map json) => PayloadEmptyModel();

  @override
  Map toJson() => {};
}
