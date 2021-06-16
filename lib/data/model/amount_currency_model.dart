import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/amount_currency.dart';

class AmountCurrencyModel extends AmountCurrency implements ToJsonInterface {
  const AmountCurrencyModel(double amount, String currency)
      : super(amount, currency);

  factory AmountCurrencyModel.fromJson(Map json) => AmountCurrencyModel(
        json['amount'] == null
            ? 0.0
            : (json['amount'] is int
                ? (json['amount'] as int).toDouble()
                : json['amount']),
        json['currency'] == null ? '' : json['currency'],
      );

  @override
  Map toJson() => {
        'amount': amount,
        'currency': currency,
      };
}
