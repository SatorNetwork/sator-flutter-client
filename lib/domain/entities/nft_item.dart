import 'package:satorio/domain/entities/auction_params.dart';

class NftItem {
  final String id;
  final String imageLink;
  final String tokenUri;
  final String name;
  final String description;
  final String ownerId;
  final Map<String, dynamic> tags;
  final double supply;
  final double royalties;
  final String blockchain;
  final String sellType;
  final double buyNowPrice;
  final AuctionParams? auctionParams;

  const NftItem(
    this.id,
    this.imageLink,
    this.tokenUri,
    this.name,
    this.description,
    this.ownerId,
    this.tags,
    this.supply,
    this.royalties,
    this.blockchain,
    this.sellType,
    this.buyNowPrice,
    this.auctionParams,
  );

  bool isVideoNft() {
    final List<String> videoTypes = [
      '.mp4',
      '.mov',
      '.wmv',
      '.flv',
      '.avi',
      '.mkv',
    ];

    return videoTypes.any(
      (videoType) => tokenUri.toLowerCase().endsWith(
            videoType.toLowerCase(),
          ),
    );
  }
}
