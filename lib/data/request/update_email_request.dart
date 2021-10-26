import 'package:satorio/data/model/to_json_interface.dart';

class UpdateEmailRequest implements ToJsonInterface {
  final String email;

  const UpdateEmailRequest(this.email);

  @override
  Map<String, String> toJson() =>
      {'email': email};
}
