import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadConnect extends Payload {
  final String userId;
  final String username;

  const PayloadConnect(
    this.userId,
    this.username,
  );
}
