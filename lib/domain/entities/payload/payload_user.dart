import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadUser extends Payload {
  final String userId;
  final String username;

  const PayloadUser(
    this.userId,
    this.username,
  );
}
