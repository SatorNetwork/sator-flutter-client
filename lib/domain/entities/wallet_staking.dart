class WalletStaking {
  final double totalLocked;
  final double lockedByYou;
  final double currentMultiplier;
  final double availableToLock;

  const WalletStaking(
    this.totalLocked,
    this.lockedByYou,
    this.currentMultiplier,
    this.availableToLock,
  );
}
