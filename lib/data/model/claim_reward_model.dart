import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/util/extension.dart';

class ClaimRewardModel extends ClaimReward implements ToJsonInterface {
  const ClaimRewardModel(
    String amount,
    String transactionUrl,
  ) : super(
          amount,
          transactionUrl,
        );

  factory ClaimRewardModel.fromJson(Map json) => ClaimRewardModel(
        json.parseValueAsString('amount'),
        json.parseValueAsString('transaction_url'),
      );

  @override
  Map toJson() => {
        'amount': amount,
        'transaction_url': transactionUrl,
      };
}
