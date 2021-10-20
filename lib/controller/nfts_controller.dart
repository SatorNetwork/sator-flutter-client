import 'package:get/get.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class NftsController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  void toNftCategory() {
    // Get.to(
    //   () => NftCategoriesPage(),
    //   binding: NftCategoriesBinding(),
    //   arguments: NftCategoriesArgument(nftCategory);
    // );
  }
}
