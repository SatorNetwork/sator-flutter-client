import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';

class WalletBalanceModel extends WalletBalance implements ToJsonInterface {
  const WalletBalanceModel(List<AmountCurrency> data)
      : super(data);

  factory WalletBalanceModel.fromJson(Map json) => WalletBalanceModel(
        (json['data'] == null || !(json['data'] is Iterable))
            ? []
            : (json['data'] as Iterable)
                .where((element) => element != null)
                .map((element) => AmountCurrencyModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'data': amountCurrencies
            .map((amountCurrency) =>
                (amountCurrency as ToJsonInterface).toJson())
            .toList(),
      };
}
