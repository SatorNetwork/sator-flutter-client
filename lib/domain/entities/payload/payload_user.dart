import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadUser extends Payload {
  final String userId;
  final String username;
  final String avatar;

  const PayloadUser(
    this.userId,
    this.username,
    this.avatar,
  );
}
