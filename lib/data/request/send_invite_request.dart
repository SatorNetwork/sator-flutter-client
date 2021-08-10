import 'package:satorio/data/model/to_json_interface.dart';

class SendInviteRequest implements ToJsonInterface {
  final String email;

  const SendInviteRequest(this.email);

  @override
  Map toJson() => {'email': email};
}
