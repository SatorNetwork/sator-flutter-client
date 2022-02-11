import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/nft_metadata.dart';
import 'package:satorio/util/extension.dart';

class NftMetadataModel extends NftMetadata implements ToJsonInterface {
  const NftMetadataModel(
    String name,
    String symbol,
    String description,
    String feePoints,
    String animationUrl,
    String externalUrl,
  ) : super(
          name,
          symbol,
          description,
          feePoints,
          animationUrl,
          externalUrl,
        );

  factory NftMetadataModel.fromJson(Map json) => NftMetadataModel(
        json.parseValueAsString('name'),
        json.parseValueAsString('symbol'),
        json.parseValueAsString('description'),
        json.parseValueAsString('seller_fee_basis_points'),
        json.parseValueAsString('animation_url'),
        json.parseValueAsString('external_url'),
      );

  @override
  Map toJson() => {
        'name': name,
        'symbol': symbol,
        'description': description,
        'seller_fee_basis_points': feePoints,
        'animation_url': animationUrl,
        'external_url': externalUrl,
      };
}
