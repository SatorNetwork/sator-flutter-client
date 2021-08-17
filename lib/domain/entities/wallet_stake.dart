import 'package:satorio/domain/entities/wallet_loyalty.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';

class WalletStake {
  final WalletStaking? walletStaking;
  final WalletLoyalty? walletLoyalty;

  const WalletStake(this.walletStaking, this.walletLoyalty);
}
