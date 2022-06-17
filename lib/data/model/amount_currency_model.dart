import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/util/extension.dart';

class AmountCurrencyModel extends AmountCurrency implements ToJsonInterface {
  AmountCurrencyModel(
    double amount,
    String currency,
  ) : super(
          amount,
          currency,
        );

  factory AmountCurrencyModel.fromJson(Map json) => AmountCurrencyModel(
        json.parseValueAsDouble('amount'),
        json.parseValueAsString('currency'),
      );

  @override
  Map toJson() => {
        'amount': amount,
        'currency': currency,
      };
}
