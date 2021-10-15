import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/auction_params.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/util/extension.dart';

import 'auction_params_model.dart';

class NftItemModel extends NftItem implements ToJsonInterface {
  const NftItemModel(
    String id,
    String imageLink,
    String name,
    String description,
    Map<String, String> tags,
    double supply,
    double royalties,
    String blockchain,
    String sellType,
    AuctionParams? auctionParams,
  ) : super(
          id,
          imageLink,
          name,
          description,
          tags,
          supply,
          royalties,
          blockchain,
          sellType,
          auctionParams,
        );

  factory NftItemModel.fromJson(Map json) => NftItemModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('image_link'),
        json.parseValueAsString('name'),
        json.parseValueAsString('description'),
        json['tags'] == null ? {} : json['tags'],
        json.parseValueAsDouble('supply'),
        json.parseValueAsDouble('royalties'),
        json.parseValueAsString('blockchain'),
        json.parseValueAsString('sell_type'),
        json['auction_params'] == null
            ? null
            : AuctionParamsModel.fromJson(json['auction_params']),
      );

  @override
  Map toJson() => {
        'id': id,
        'image_link': imageLink,
        'name': name,
        'description': description,
        // 'tags': tags,
        'supply': supply,
        'royalties': royalties,
        'blockchain': blockchain,
        'sell_type': sellType,
        'auction_params': (auctionParams as ToJsonInterface).toJson(),
      };
}
