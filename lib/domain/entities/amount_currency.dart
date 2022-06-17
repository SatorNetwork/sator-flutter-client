class AmountCurrency {
  double amount;
  final String currency;

  AmountCurrency(this.amount, this.currency);

  get displayedValue => '${amount.toStringAsFixed(2)} $currency';
}
