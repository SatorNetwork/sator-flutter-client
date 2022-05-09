import 'package:satorio/data/model/to_json_interface.dart';

class RegisterIapRequest implements ToJsonInterface {
  final String transactionReceipt;
  final String mintAddress;

  const RegisterIapRequest(this.transactionReceipt, this.mintAddress);

  @override
  Map toJson() => {
        'receipt_data': transactionReceipt,
        'mint_address': mintAddress,
      };
}
