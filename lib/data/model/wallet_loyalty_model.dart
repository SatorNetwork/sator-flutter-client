import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_loyalty.dart';

class WalletLoyaltyModel extends WalletLoyalty implements ToJsonInterface {
  const WalletLoyaltyModel(String levelTitle, String levelSubtitle)
      : super(levelTitle, levelSubtitle);

  factory WalletLoyaltyModel.fromJson(Map json) => WalletLoyaltyModel(
        json['level_title'] == null ? '' : json['level_title'],
        json['level_subtitle'] == null ? '' : json['level_subtitle'],
      );

  @override
  Map toJson() => {
        'level_title': levelTitle,
        'level_subtitle': levelSubtitle,
      };
}
