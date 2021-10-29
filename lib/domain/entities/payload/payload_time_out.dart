import 'package:satorio/domain/entities/payload/payload.dart';

class PayloadTimeOut extends Payload {
  final String message;

  const PayloadTimeOut(this.message);
}
