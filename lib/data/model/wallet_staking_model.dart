import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';
import 'package:satorio/util/extension.dart';

class WalletStakingModel extends WalletStaking implements ToJsonInterface {
  const WalletStakingModel(
    double totalLocked,
    double lockedByYou,
    double currentMultiplier,
    double availableToLock,
  ) : super(
          totalLocked,
          lockedByYou,
          currentMultiplier,
          availableToLock,
        );

  factory WalletStakingModel.fromJson(Map json) => WalletStakingModel(
        json.parseValueAsDouble('TotalLocked'),
        json.parseValueAsDouble('LockedByYou'),
        json.parseValueAsDouble('CurrentMultiplier'),
        json.parseValueAsDouble('AvailableToLock'),
      );

  @override
  Map toJson() => {
        'TotalLocked': totalLocked,
        'LockedByYou': lockedByYou,
        'CurrentMultiplier': currentMultiplier,
        'AvailableToLock': availableToLock,
      };
}
