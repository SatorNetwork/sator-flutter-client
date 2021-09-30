import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/model/wallet_loyalty_model.dart';
import 'package:satorio/data/model/wallet_staking_model.dart';
import 'package:satorio/domain/entities/wallet_loyalty.dart';
import 'package:satorio/domain/entities/wallet_stake.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';

class WalletStakeModel extends WalletStake implements ToJsonInterface {
  const WalletStakeModel(
    WalletStaking? walletStaking,
    WalletLoyalty? walletLoyalty,
  ) : super(
          walletStaking,
          walletLoyalty,
        );

  factory WalletStakeModel.fromJson(Map json) => WalletStakeModel(
        json['staking'] == null
            ? null
            : WalletStakingModel.fromJson(json['staking']),
        json['loyalty'] == null
            ? null
            : WalletLoyaltyModel.fromJson(json['loyalty']),
      );

  @override
  Map toJson() => {
        'staking': (walletStaking as ToJsonInterface).toJson(),
        'loyalty': (walletLoyalty as ToJsonInterface).toJson(),
      };
}
