class AmountCurrency {
  final double amount;
  final String currency;

  const AmountCurrency(this.amount, this.currency);

  get displayedValue => '${amount.toStringAsFixed(2)} $currency';
}
