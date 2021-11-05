import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/auction_params.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/util/extension.dart';

import 'auction_params_model.dart';

class NftItemModel extends NftItem implements ToJsonInterface {
  const NftItemModel(
    String id,
    String imageLink,
    String tokenUri,
    String name,
    String description,
    String ownerId,
    Map<String, dynamic> tags,
    double supply,
    double royalties,
    String blockchain,
    String sellType,
    double buyNowPrice,
    AuctionParams? auctionParams,
  ) : super(
          id,
          imageLink,
          tokenUri,
          name,
          description,
          ownerId,
          tags,
          supply,
          royalties,
          blockchain,
          sellType,
          buyNowPrice,
          auctionParams,
        );

  factory NftItemModel.fromJson(Map json) => NftItemModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('image_link'),
        json.parseValueAsString('token_uri'),
        json.parseValueAsString('name'),
        json.parseValueAsString('description'),
        json.parseValueAsString('owner_id'),
        json['tags'] == null ? {} : json['tags'],
        json.parseValueAsDouble('supply'),
        json.parseValueAsDouble('royalties'),
        json.parseValueAsString('blockchain'),
        json.parseValueAsString('sell_type'),
        json.parseValueAsDouble('buy_now_price'),
        json['auction_params'] == null
            ? null
            : AuctionParamsModel.fromJson(json['auction_params']),
      );

  @override
  Map toJson() => {
        'id': id,
        'image_link': imageLink,
        'token_uri': tokenUri,
        'name': name,
        'description': description,
        'owner_id': ownerId,
        'tags': tags,
        'supply': supply,
        'royalties': royalties,
        'blockchain': blockchain,
        'sell_type': sellType,
        'auction_params': (auctionParams as ToJsonInterface).toJson(),
      };
}
