import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/model/wallet_action_model.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_action.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';

class WalletDetailModel extends WalletDetail implements ToJsonInterface {
  const WalletDetailModel(
    String id,
    String solanaAccountAddress,
    int order,
    List<AmountCurrency> balance,
    List<WalletAction> actions,
  ) : super(id, solanaAccountAddress, order, balance, actions);

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
      json['id'] == null ? '' : json['id'],
      json['solana_account_address'] == null
          ? ''
          : json['solana_account_address'],
      json['order'] == null ? 0 : json['order'],
      balance,
      actions,
    );
  }

  @override
  Map toJson() => {
        'id': id,
        'solana_account_address': solanaAccountAddress,
        'order': order,
        'balance': balance
            .where((element) => element is ToJsonInterface)
            .map((element) => (element as ToJsonInterface).toJson())
            .toList(),
        'actions': actions
            .where((element) => element is ToJsonInterface)
            .map((element) => (element as ToJsonInterface).toJson())
            .toList(),
      };
}
