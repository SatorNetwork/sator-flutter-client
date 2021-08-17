class WalletStaking {
  final String assetName;
  final double apy;
  final double totalStaked;
  final double staked;
  final double yourShare;

  const WalletStaking(
    this.assetName,
    this.apy,
    this.totalStaked,
    this.staked,
    this.yourShare,
  );
}
