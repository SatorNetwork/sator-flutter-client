import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/user_nft_item.dart';
import 'package:satorio/util/extension.dart';

class UserNftItemModel extends UserNftItem implements ToJsonInterface {
  const UserNftItemModel(
    String name,
    String symbol,
    String description,
    int sellerFee,
    String image,
  ) : super(name, symbol, description, sellerFee, image);

  factory UserNftItemModel.fromJson(Map json) => UserNftItemModel(
        json.parseValueAsString('name'),
        json.parseValueAsString('symbol'),
        json.parseValueAsString('description'),
        json.parseValueAsInt('seller_fee_basis_points'),
        json.parseValueAsString('image'),
      );

  @override
  Map toJson() => {
        'name': name,
        'symbol': symbol,
        'description': description,
        'seller_fee_basis_points': sellerFee,
        'image': image,
      };
}
