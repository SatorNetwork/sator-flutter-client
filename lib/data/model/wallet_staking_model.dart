import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';
import 'package:satorio/util/extension.dart';

class WalletStakingModel extends WalletStaking implements ToJsonInterface {
  const WalletStakingModel(
    String assetName,
    double apy,
    double totalStaked,
    double staked,
    double yourShare,
  ) : super(
          assetName,
          apy,
          totalStaked,
          staked,
          yourShare,
        );

  factory WalletStakingModel.fromJson(Map json) => WalletStakingModel(
        json.parseValueAsString('asset_name'),
        json.parseValueAsDouble('apy'),
        json.parseValueAsDouble('total_staked'),
        json.parseValueAsDouble('staked'),
        json.parseValueAsDouble('your_share'),
      );

  @override
  Map toJson() => {
        'asset_name': assetName,
        'apy': apy,
        'total_staked': totalStaked,
        'staked': staked,
        'your_share': yourShare,
      };
}
