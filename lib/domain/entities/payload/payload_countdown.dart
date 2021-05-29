import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadCountdown extends Payload {
  final int countdown;

  const PayloadCountdown(
    this.countdown,
  );
}
