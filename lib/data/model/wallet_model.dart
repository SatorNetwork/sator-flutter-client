import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/util/extension.dart';

class WalletModel extends Wallet implements ToJsonInterface {
  const WalletModel(
    String id,
    String detailsUrl,
    String transactionsUrl,
  ) : super(
          id,
          detailsUrl,
          transactionsUrl,
        );

  factory WalletModel.fromJson(Map json) => WalletModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('get_details_url'),
        json.parseValueAsString('get_transactions_url'),
      );

  @override
  Map toJson() => {
        'id': id,
        'get_details_url': detailsUrl,
        'get_transactions_url': transactionsUrl,
      };
}
