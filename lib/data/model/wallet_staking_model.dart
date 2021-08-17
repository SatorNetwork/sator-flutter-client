import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';

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
        json['asset_name'] == null ? '' : json['asset_name'],
        json['apy'] == null
            ? 0.0
            : (json['apy'] is int
                ? (json['apy'] as int).toDouble()
                : json['apy']),
        json['total_staked'] == null
            ? 0.0
            : (json['total_staked'] is int
                ? (json['total_staked'] as int).toDouble()
                : json['total_staked']),
        json['staked'] == null
            ? 0.0
            : (json['staked'] is int
                ? (json['staked'] as int).toDouble()
                : json['staked']),
        json['your_share'] == null
            ? 0.0
            : (json['your_share'] is int
                ? (json['your_share'] as int).toDouble()
                : json['your_share']),
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
