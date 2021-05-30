import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadWinner extends Payload {
  final String userId;
  final String username;
  final String prize;

  const PayloadWinner(
    this.userId,
    this.username,
    this.prize,
  );
}
