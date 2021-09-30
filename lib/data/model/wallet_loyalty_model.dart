import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/wallet_loyalty.dart';
import 'package:satorio/util/extension.dart';

class WalletLoyaltyModel extends WalletLoyalty implements ToJsonInterface {
  const WalletLoyaltyModel(
    String levelTitle,
    String levelSubtitle,
  ) : super(
          levelTitle,
          levelSubtitle,
        );

  factory WalletLoyaltyModel.fromJson(Map json) => WalletLoyaltyModel(
        json.parseValueAsString('level_title'),
        json.parseValueAsString('level_subtitle'),
      );

  @override
  Map toJson() => {
        'level_title': levelTitle,
        'level_subtitle': levelSubtitle,
      };
}
