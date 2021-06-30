import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_action.dart';

class WalletDetail {
  final String id;
  final String solanaAccountAddress;
  final List<AmountCurrency> balance;
  final List<WalletAction> actions;

  const WalletDetail(
      this.id, this.solanaAccountAddress, this.balance, this.actions);
}
