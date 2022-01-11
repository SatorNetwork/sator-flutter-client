import 'package:satorio/data/model/to_json_interface.dart';

class PublicKeyRequest implements ToJsonInterface {
  final String publicKey;

  const PublicKeyRequest(this.publicKey);

  @override
  Map toJson() => {
        'public_key': publicKey,
      };
}
