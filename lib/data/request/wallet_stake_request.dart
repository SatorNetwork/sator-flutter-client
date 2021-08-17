import 'package:satorio/data/model/to_json_interface.dart';

class WalletStakeRequest implements ToJsonInterface {
  final double amount;

  const WalletStakeRequest(this.amount);

  @override
  Map toJson() => {
        'amount': amount,
      };
}
