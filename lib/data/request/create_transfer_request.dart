import 'package:satorio/data/model/to_json_interface.dart';

class CreateTransferRequest implements ToJsonInterface {
  final String recipientAddress;
  final double amount;

  const CreateTransferRequest(this.recipientAddress, this.amount);

  @override
  Map toJson() => {
        'recipient_address': recipientAddress,
        'amount': amount,
      };
}
