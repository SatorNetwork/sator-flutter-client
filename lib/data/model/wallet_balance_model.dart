import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';

class WalletBalanceModel extends WalletBalance implements ToJsonInterface {
  const WalletBalanceModel(AmountCurrency sao, AmountCurrency usd)
      : super(sao, usd);

  factory WalletBalanceModel.fromJson(Map json) => WalletBalanceModel(
        AmountCurrencyModel.fromJson(json['sao']),
        AmountCurrencyModel.fromJson(json['usd']),
      );

  @override
  Map toJson() => {
        'sao': (sao as ToJsonInterface).toJson(),
        'usd': (usd as ToJsonInterface).toJson(),
      };
}
