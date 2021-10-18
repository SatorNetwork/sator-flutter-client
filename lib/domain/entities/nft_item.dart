import 'package:satorio/domain/entities/auction_params.dart';

class NftItem {
  final String id;
  final String imageLink;
  final String name;
  final String description;
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
    this.name,
    this.description,
    this.tags,
    this.supply,
    this.royalties,
    this.blockchain,
    this.sellType,
    this.buyNowPrice,
    this.auctionParams,
  );
}
