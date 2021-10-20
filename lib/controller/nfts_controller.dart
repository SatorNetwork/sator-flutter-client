import 'package:get/get.dart';
import 'package:satorio/binding/nft_categories_binding.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nfts_categories_page.dart';

class NftsController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<NftHome?> nftHomeRx = Rx(null);

  @override
  void onInit() {
    super.onInit();
    _loadNftHome();
  }

  void toNftCategory() {
    if (nftHomeRx.value != null) {
      Get.to(
        () => NftCategoriesPage(),
        binding: NftCategoriesBinding(),
        arguments: NftCategoriesArgument(nftHomeRx.value!.id),
      );
    }
  }

  void toNftItem(NftItem? nftItem) {
    if (nftItem != null) {
      Get.to(
        () => NftItemPage(),
        binding: NftItemBinding(),
        arguments: NftItemArgument(nftItem),
      );
    }
  }

  void refreshData() {
    _loadNftHome();
  }

  void _loadNftHome() {
    _satorioRepository.nftHome().then(
      (NftHome nftHome) {
        nftHomeRx.value = nftHome;
      },
    );
  }
}
