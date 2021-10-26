import 'package:satorio/domain/entities/nft_item.dart';

class NftHome {
  final String id;
  final String title;
  final List<NftItem> items;

  const NftHome(
    this.id,
    this.title,
    this.items,
  );
}
