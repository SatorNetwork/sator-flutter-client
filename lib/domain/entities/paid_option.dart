class PaidOption {
  final String text;
  final double amount;
  final int hours;
  final String label;

  const PaidOption(this.text, this.amount, this.hours, this.label);

  static List<PaidOption> available = [
    PaidOption('2h for', 2.0, 2, 'unlock_opt_2h'),
    PaidOption('24h for', 10.0, 24, 'unlock_opt_24h'),
    PaidOption('week for', 50.0, 7 * 24, 'unlock_opt_week'),
  ];
}
