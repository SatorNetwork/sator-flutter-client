import 'package:satorio/data/model/to_json_interface.dart';

class ConfirmTransferRequest implements ToJsonInterface {
  final String txHash;

  const ConfirmTransferRequest(this.txHash);

  @override
  Map toJson() => {
        'tx_hash': txHash,
      };
}
