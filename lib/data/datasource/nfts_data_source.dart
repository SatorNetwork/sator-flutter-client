import 'package:satorio/data/model/nft_category_model.dart';
import 'package:satorio/data/model/nft_item_model.dart';

abstract class NftsDataSource {
  Future<void> init();

  Future<List<NftCategoryModel>> nftCategories();

  Future<List<NftItemModel>> allNfts({
    int? page,
    int? itemsPerPage,
  });
}
