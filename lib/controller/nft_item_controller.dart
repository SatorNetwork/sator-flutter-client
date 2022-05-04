import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
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
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/util/links.dart';
import 'package:url_launcher/url_launcher.dart';

class NftItemController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<NftItem> nftItemRx;
  late final RxBool isOwner = true.obs;

  final RxBool isBuyRequested = false.obs;
  final RxBool termsOfUseCheck = false.obs;

  String productId = "";
  List<IAPItem> products = [];

  late final StreamSubscription _purchaseUpdatedSubscription;
  late final StreamSubscription _purchaseErrorSubscription;
  late final StreamSubscription _connectionSubscription;

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

    _initializeInApp();

    marketplaceUrl = await _satorioRepository.nftsMarketplaceUrl();
  }

  void back() {
    Get.back();
  }

  void toMarketplace(String id) async {
    await canLaunch('$marketplaceUrl/nft-item?id=$id')
        ? await launch('$marketplaceUrl/nft-item?id=$id')
        : throw '$marketplaceUrl/nft-item?id=$id';
  }

  Future<void> _initializeInApp() async {
    try {
      _satorioRepository.initializePurchase();

      _getInAppProducts();

      List<PurchasedItem>? purchasedList;

      if (products.isNotEmpty) {
        if (isAndroid) {
          purchasedList = await _satorioRepository.purchaseHistory();

          if (purchasedList != null &&
              purchasedList.contains(PurchasedItem) &&
              purchasedList.isNotEmpty) {
            await _satorioRepository.consumeAll();
          }
        }
      }

      _connectionSubscription =
          FlutterInappPurchase.connectionUpdated.listen((connected) {
            //TODO: remove after tests
            print('connected: $connected');
          });

      _purchaseUpdatedSubscription =
          FlutterInappPurchase.purchaseUpdated.listen((product) async {
            //TODO: remove after tests
            print('purchase-product: $product');
            Map<String, dynamic> json = {};

            await _satorioRepository.consumeAll();

            if (isAndroid && product != null) {
              json = jsonDecode(product.transactionReceipt!);
            }

            await verifyTransaction(
              data: product!.transactionReceipt!,
              signature: isAndroid ? product.signatureAndroid! : '',
              json: isAndroid ? json : {},
              token: isAndroid ? product.purchaseToken! : '',
              purchasedItemIOS: product,
            );
          });

      _purchaseErrorSubscription =
          FlutterInappPurchase.purchaseError.listen((purchaseError) async {
            _purchaseErrorSubscription.pause();
            _purchaseErrorSubscription.resume();
          });
    } on PlatformException catch (err) {
      //TODO: remove after tests and add response after API callback
      print(err);
    }
  }

  void _getInAppProducts() {
    _satorioRepository.inAppProductsIds().then((ids) {
      if (ids == null) return;

      _satorioRepository.getProducts(ids).then((value) {
        products = value;

        products.sort((a, b) => a.price!.compareTo(b.price!));

        _setInAppProduct();
      });
    });
  }

  void _setInAppProduct() {
    for (int i = 0; i < products.length; i++) {
      double inAppPrice = double.parse(products[i].price!);

      if (nftItemRx.value.priceInUsd <= inAppPrice) {
        productId = products[i].productId!;
        break;
      }
    }
  }

  Future<void> buyInAppProduct() async {
    if (productId.isEmpty || productId == "") return;

    _satorioRepository.buyInAppProduct(productId);
  }

  Future<void> verifyTransaction({
    required String data,
    required String signature,
    required Map<String, dynamic> json,
    required String token,
    required PurchasedItem purchasedItemIOS,
  }) async {
    await _satorioRepository
        .finishTransaction(purchasedItemIOS, true)
        .then((value) {
      if (value != null) {
        _satorioRepository.buyNftIap(
            purchasedItemIOS.transactionReceipt!, nftItemRx.value.mintAddress).then((value) {
              if (value) {
                Get.back();
              }
        });
      }
    }).catchError((error) {
      //TODO: remove after tests and add response after API callback
      print(error);
    });
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
  final NftItem nftItem;

  const NftItemArgument(this.nftItem);
}
