class SaoWalletConfig {
  final String walletPublicKey;
  final String walletPrivateKey;
  final String tokenSymbol;
  final String tokenMintAddress;

  const SaoWalletConfig(
    this.walletPublicKey,
    this.walletPrivateKey,
    this.tokenSymbol,
    this.tokenMintAddress,
  );
}
