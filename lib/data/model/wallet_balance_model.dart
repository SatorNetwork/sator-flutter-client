import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';

class WalletBalanceModel extends WalletBalance implements ToJsonInterface {
  const WalletBalanceModel(List<AmountCurrency> amountCurrencies)
      : super(amountCurrencies);

  factory WalletBalanceModel.fromJson(Map json) => WalletBalanceModel(
        (json == null || !(json is Iterable))
            ? []
            : (json as Iterable)
                .where((element) => element != null)
                .map((element) => AmountCurrencyModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        //  wrapped in 'data'
        'data': amountCurrencies
            .map((amountCurrency) =>
                (amountCurrency as ToJsonInterface).toJson())
            .toList(),
      };
}
