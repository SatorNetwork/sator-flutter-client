import 'package:satorio/domain/entities/nft_metadata.dart';

class NftItem {
  final String mintAddress;
  final String owner;
  final bool onSale;
  final double buyNowPrice;
  final String collectionId;
  final NftMetadata nftMetadata;
  final String nftLink;
  final String nftPreview;

  const NftItem(
    this.mintAddress,
    this.owner,
    this.onSale,
    this.buyNowPrice,
    this.collectionId,
    this.nftMetadata,
    this.nftLink,
    this.nftPreview,
  );

// bool isVideoNft() {
//   final List<String> videoTypes = [
//     '.mp4',
//     '.mov',
//     '.wmv',
//     '.flv',
//     '.avi',
//     '.mkv',
//   ];
//
//   return videoTypes.any(
//     (videoType) => tokenUri.toLowerCase().endsWith(
//           videoType.toLowerCase(),
//         ),
//   );
// }
}
