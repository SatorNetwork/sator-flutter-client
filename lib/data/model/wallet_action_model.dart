import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_action.dart';

class WalletActionModel extends WalletAction implements ToJsonInterface {
  const WalletActionModel(String type, String name, String url)
      : super(type, name, url);

  factory WalletActionModel.fromJson(Map json) => WalletActionModel(
        json['type'] == null ? '' : json['type'],
        json['name'] == null ? '' : json['name'],
        json['url'] == null ? '' : json['url'],
      );

  @override
  Map toJson() => {
        'type': type,
        'name': name,
        'url': url,
      };
}
