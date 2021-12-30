import 'package:satorio/data/model/to_json_interface.dart';

class SendTipRequest implements ToJsonInterface {
  final double amount;

  const SendTipRequest(this.amount);

  @override
  Map toJson() => {
        'amount': amount,
      };
}
