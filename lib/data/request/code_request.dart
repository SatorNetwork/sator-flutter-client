import 'package:satorio/data/model/to_json_interface.dart';

class CodeRequest implements ToJsonInterface {
  final String code;

  const CodeRequest(this.code);

  @override
  Map toJson() => {
        'code': code,
      };
}
