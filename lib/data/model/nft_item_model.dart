import 'package:satorio/data/model/nft_metadata_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/nft_metadata.dart';
import 'package:satorio/util/extension.dart';

class NftItemModel extends NftItem implements ToJsonInterface {
  const NftItemModel(
    String mintAddress,
    String owner,
    bool onSale,
    double buyNowPrice,
    double priceInUsd,
    String collectionId,
    NftMetadata nftMetadata,
    String nftLink,
    String nftPreview,
  ) : super(
          mintAddress,
          owner,
          onSale,
          buyNowPrice,
          priceInUsd,
          collectionId,
          nftMetadata,
          nftLink,
          nftPreview,
        );

  factory NftItemModel.fromJson(Map json) => NftItemModel(
        json.parseValueAsString('mint_address'),
        json.parseValueAsString('owner'),
        json.parseValueAsBool('on_sale'),
        json.parseValueAsDouble('by_now_price'),
        json.parseValueAsDouble('price_in_usd'),
        json.parseValueAsString('collection_id'),
        NftMetadataModel.fromJson(json['arweave_nft_metadata']),
        json.parseValueAsString('nft_link'),
        json.parseValueAsString('nft_preview_link'),
      );

  @override
  Map toJson() => {
        'mint_address': mintAddress,
        'owner': owner,
        'on_sale': onSale,
        'by_now_price': buyNowPrice,
        'price_in_usd': priceInUsd,
        'collection_id': collectionId,
        'arweave_nft_metadata': (nftMetadata as ToJsonInterface).toJson(),
        'nft_link': nftLink,
        'nft_preview_link': nftPreview,
      };
}
