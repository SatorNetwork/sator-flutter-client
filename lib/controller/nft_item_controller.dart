import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/checkout_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/success_nft_bought_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/web_page.dart';
import 'package:satorio/util/links.dart';
import 'package:url_launcher/url_launcher.dart';

class NftItemController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<NftItem> nftItemRx;
  late final RxBool isOwner = true.obs;

  final RxBool isBuyRequested = false.obs;
  final RxBool termsOfUseCheck = false.obs;

  late final String marketplaceUrl;

  NftItemController() {
    NftItemArgument argument = Get.arguments as NftItemArgument;

    nftItemRx = Rx(argument.nftItem);
    _checkOwner();
    _refreshNftItem(argument.nftItem.mintAddress);
  }

  @override
  void onInit() async {
    super.onInit();

    marketplaceUrl = await _satorioRepository.nftsMarketplaceUrl();
  }

  void back() {
    Get.back();
  }

  void toMarketplace(String id) async {
    final Uri url = Uri.parse('$marketplaceUrl/nft-item?id=$id');
    if (!await launchUrl(url)) throw 'Could not launch $url';
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

  // void toNetworkVideo() {
  //   if (nftItemRx.value.isVideoNft()) {
  //     Get.to(
  //       () => VideoNetworkPage(),
  //       binding: VideoNetworkBinding(),
  //       arguments: VideoNetworkArgument(nftItemRx.value.tokenUri),
  //     );
  //   }
  // }

  void buy() {
    Profile? profile = _getProfile();
    Future.value(true)
        .then(
          (value) {
            isBuyRequested.value = true;
            return value;
          },
        )
        .then(
          (value) => _satorioRepository.buyNftItem(nftItemRx.value.mintAddress),
        )
        .then(
          (isSuccess) {
            if (isSuccess) {
              Get.bottomSheet(
                SuccessNftBoughtBottomSheet(
                    nftItemRx.value.nftMetadata.name, profile!.id),
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

  void _refreshNftItem(String mintAddress) {
    _satorioRepository.nft(mintAddress).then((NftItem nftItem) {
      nftItemRx.value = nftItem;
      _checkOwner();
    });
  }

  void _checkOwner() {
    Profile? profile = _getProfile();
    if (profile != null) {
      isOwner.value = nftItemRx.value.owner == profile.id;
    }
  }

  Profile? _getProfile() {
    return (_satorioRepository.profileListenable()
            as ValueListenable<Box<Profile>>)
        .value
        .getAt(0);
  }
}

class NftItemArgument {
  final  NftItem nftItem;

  const NftItemArgument(this.nftItem);
}
