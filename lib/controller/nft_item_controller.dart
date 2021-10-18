import 'package:get/get.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/checkout_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/success_nft_bought_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/web_page.dart';
import 'package:satorio/util/links.dart';

class NftItemController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<NftItem> nftItemRx;

  final RxBool isBuyRequested = false.obs;
  final RxBool termsOfUseCheck = false.obs;

  NftItemController() {
    NftItemArgument argument = Get.arguments as NftItemArgument;

    nftItemRx = Rx(argument.nftItem);
    _refreshNftItem(argument.nftItem.id);
  }

  void back() {
    Get.back();
  }

  void addToFavourite() {}

  void toCheckout() {
    Get.bottomSheet(
      CheckoutBottomSheet(this),
      isScrollControlled: true,
    );
  }

  void toTermsOfUse() {
    Get.to(
      () => WebPage(),
      binding: WebBinding(),
      arguments: WebArgument(
        linkTermsOfUse,
      ),
    );
  }

  void buy() {
    Future.value(true)
        .then(
          (value) {
            isBuyRequested.value = true;
            return value;
          },
        )
        .then(
          (value) => _satorioRepository.buyNftItem(nftItemRx.value.id),
        )
        .then(
          (isSuccess) {
            if (isSuccess) {
              Get.bottomSheet(
                SuccessNftBoughtBottomSheet(nftItemRx.value.name),
              );
            }
            isBuyRequested.value = false;
          },
        )
        .catchError(
          (value) {
            isBuyRequested.value = false;
          },
        );
  }

  void _refreshNftItem(String nftItemId) {
    _satorioRepository.nftItem(nftItemId).then((NftItem nftItem) {
      nftItemRx.value = nftItem;
    });
  }
}

class NftItemArgument {
  final NftItem nftItem;

  const NftItemArgument(this.nftItem);
}
