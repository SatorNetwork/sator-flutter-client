import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_action.dart';
import 'package:satorio/util/extension.dart';

class WalletActionModel extends WalletAction implements ToJsonInterface {
  const WalletActionModel(
    String type,
    String name,
    String url,
  ) : super(
          type,
          name,
          url,
        );

  factory WalletActionModel.fromJson(Map json) => WalletActionModel(
        json.parseValueAsString('type'),
        json.parseValueAsString('name'),
        json.parseValueAsString('url'),
      );

  @override
  Map toJson() => {
        'type': type,
        'name': name,
        'url': url,
      };
}
