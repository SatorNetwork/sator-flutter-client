class StakeLevel {
  final String id;
  final double minAmount;
  final double minDaysToStake;
  final String title;
  final String subTitle;
  final String rewards;
  final bool isCurrent;

  const StakeLevel(this.id, this.minAmount, this.minDaysToStake, this.title,
      this.subTitle, this.rewards, this.isCurrent);
}
