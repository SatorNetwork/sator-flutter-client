import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/model/wallet_action_model.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_action.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/util/extension.dart';

class WalletDetailModel extends WalletDetail implements ToJsonInterface {
  const WalletDetailModel(String id, String solanaAccountAddress, int order,
      List<AmountCurrency> balance, List<WalletAction> actions, String type)
      : super(
          id,
          solanaAccountAddress,
          order,
          balance,
          actions,
          type,
        );

  factory WalletDetailModel.fromJson(Map json) {
    List<AmountCurrency> balance =
        (json['balance'] == null || !(json['balance'] is Iterable))
            ? []
            : (json['balance'] as Iterable)
                .where((element) => element != null)
                .map((element) => AmountCurrencyModel.fromJson(element))
                .toList();

    List<WalletAction> actions =
        (json['actions'] == null || !(json['actions'] is Iterable))
            ? []
            : (json['actions'] as Iterable)
                .where((element) => element != null)
                .map((element) => WalletActionModel.fromJson(element))
                .toList();

    return WalletDetailModel(
      json.parseValueAsString('id'),
      json.parseValueAsString('solana_account_address'),
      json.parseValueAsInt('order'),
      balance,
      actions,
      json.parseValueAsString('type'),
    );
  }

  @override
  Map toJson() => {
        'id': id,
        'solana_account_address': solanaAccountAddress,
        'order': order,
        'balance': balance
            .whereType<ToJsonInterface>()
            .map((element) => element.toJson())
            .toList(),
        'actions': actions
            .whereType<ToJsonInterface>()
            .map((element) => element.toJson())
            .toList(),
        'type': type,
      };
}
