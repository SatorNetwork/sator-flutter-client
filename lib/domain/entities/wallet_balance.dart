import 'package:satorio/domain/entities/amount_currency.dart';

class WalletBalance {
  final AmountCurrency sao;
  final AmountCurrency usd;

  const WalletBalance(this.sao, this.usd);
}
