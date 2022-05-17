import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_action.dart';

class WalletDetail {
  final String id;
  final String solanaAccountAddress;
  final int order;
  final List<AmountCurrency> balance;
  final List<WalletAction> actions;
  final String type;

  const WalletDetail(this.id, this.solanaAccountAddress, this.order,
      this.balance, this.actions, this.type);
}
