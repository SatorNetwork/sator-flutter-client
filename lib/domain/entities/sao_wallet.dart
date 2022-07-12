import 'package:satorio/domain/entities/sao_wallet_config.dart';

class SaoWallet extends SaoWalletConfig {
  final double amount;

  const SaoWallet(
    String walletPublicKey,
    String walletPrivateKey,
    String tokenSymbol,
    String tokenMintAddress,
    this.amount,
  ) : super(
          walletPublicKey,
          walletPrivateKey,
          tokenSymbol,
          tokenMintAddress,
        );

  get displayedValue => '${amount.toStringAsFixed(2)} $tokenSymbol';
}
