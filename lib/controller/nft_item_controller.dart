import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/mixin/connectivity_mixin.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/checkout_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/success_nft_bought_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/web_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/util/links.dart';

class NftItemController extends GetxController
    with BackToMainMixin, ConnectivityMixin, NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<NftItem> nftItemRx;
  late final RxBool isOwner = true.obs;
  late final RxString itemPrice = ''.obs;

  final RxBool isBuyRequested = false.obs;
  final RxBool termsOfUseCheck = false.obs;

  String productId = "";
  List<IAPItem> products = [];

  late final StreamSubscription _purchaseUpdatedSubscription;
  late final StreamSubscription _purchaseErrorSubscription;
  late final StreamSubscription _connectionSubscription;

  late ValueListenable<Box<Wallet>> _walletsListenable;
  ValueListenable<Box<WalletDetail>>? _walletDetailsListenable;
  List<WalletDetail> walletDetails = [];
  String solanaAddress = "";

  late final String marketplaceUrl;

  NftItemController() {
    NftItemArgument argument = Get.arguments as NftItemArgument;

    nftItemRx = Rx(argument.nftItem);
    _walletsListenable =
        _satorioRepository.walletsListenable() as ValueListenable<Box<Wallet>>;

    _checkOwner();
    _refreshNftItem(argument.nftItem.mintAddress);
  }

  @override
  void onInit() async {
    super.onInit();
    _walletsListener();

    if (!isAndroid) {
      _initializeInApp();
    }

    marketplaceUrl = await _satorioRepository.nftsMarketplaceUrl();
  }

  void back() {
    Get.back();
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
        print('connected: $connected');
      });

      _purchaseUpdatedSubscription =
          FlutterInappPurchase.purchaseUpdated.listen((product) async {
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
        ).then((value) {
          _purchaseUpdatedSubscription.cancel();
          _connectionSubscription.cancel();
          _purchaseErrorSubscription.cancel();

          Future.delayed(
              Duration(seconds: 2),
              () => _satorioRepository
                      .buyNftIap(product.transactionReceipt!,
                          nftItemRx.value.mintAddress)
                      .then((value) {
                    if (value) {
                      _refreshNftsData();
                      Get.back();
                      isBuyRequested.value = false;
                    }
                  }).catchError((error) {
                    _refreshNftsData();
                    Get.back();
                    isBuyRequested.value = false;
                  }));
        });
      });

      _purchaseErrorSubscription =
          FlutterInappPurchase.purchaseError.listen((purchaseError) async {
        _purchaseErrorSubscription.pause();
        _purchaseErrorSubscription.resume();
        isBuyRequested.value = false;
      });
    } on PlatformException catch (err) {
      //TODO: remove after tests and add response after API callback
      print('error === $err');
    }
  }

  void _refreshNftsData() {
    if (Get.isRegistered<NftCategoriesController>()) {
      NftCategoriesController nftCategoriesController = Get.find();
      nftCategoriesController.refreshData();
    }

    if (Get.isRegistered<HomeController>()) {
      HomeController homeController = Get.find();
      homeController.refreshHomePage();
    }
  }

  void _getInAppProducts() {
    _satorioRepository.inAppProductsIds().then((ids) {
      if (ids == null) return;

      _satorioRepository.getProducts(ids).then((value) {
        products = value;

        products.sort(
          (a, b) => double.parse(a.price!).compareTo(double.parse(b.price!)),
        );

        _setInAppProduct();
      });
    });
  }

  void _setInAppProduct() {
    for (int i = 0; i < products.length; i++) {
      double inAppPrice = double.parse(products[i].price!);

      if (nftItemRx.value.priceInUsd <= inAppPrice) {
        productId = products[i].productId!;
        itemPrice.value = products[i].price!;
        break;
      }
    }
  }

  Future<void> buyInAppProduct() async {
    if (productId.isEmpty || productId == "") return;

    isBuyRequested.value = true;

    _satorioRepository.buyInAppProduct(productId);
  }

  Future<void> verifyTransaction({
    required String data,
    required String signature,
    required Map<String, dynamic> json,
    required String token,
    required PurchasedItem purchasedItemIOS,
  }) async {
    await _satorioRepository.finishTransaction(purchasedItemIOS, true);
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

  void _walletsListener() {
    Map<String, Wallet> wallets = {};
    // Update wallets map
    Map<String, Wallet> walletsNew = {};
    _walletsListenable.value.values.forEach((wallet) {
      walletsNew[wallet.id] = wallet;
    });
    wallets = walletsNew;

    // Ids of wallets
    List<String> ids = wallets.values.map((wallet) => wallet.id).toList();

    _walletDetailsListenable = _satorioRepository.walletDetailsListenable(ids)
        as ValueListenable<Box<WalletDetail>>;
    _walletDetailsListener();
  }

  void _walletDetailsListener() {
    walletDetails = _walletDetailsListenable!.value.values.toList();
    walletDetails.sort((a, b) => a.order.compareTo(b.order));
    _solanaAddress();
  }

  void _solanaAddress() {
    walletDetails.forEach((element) {
      print(element);
      if (element.isSolana) {
        solanaAddress = element.solanaAccountAddress;
      }
    });
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
          (value) => _satorioRepository.buyNftItem(nftItemRx.value.mintAddress),
        )
        .then(
          (isSuccess) {
            if (isSuccess) {
              Get.bottomSheet(
                SuccessNftBoughtBottomSheet(
                    nftItemRx.value.nftMetadata.name, solanaAddress),
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

  Wallet? _getWallet() {
    return (_satorioRepository.walletsListenable()
            as ValueListenable<Box<Wallet>>)
        .value
        .getAt(0);
  }
}

class NftItemArgument {
  final NftItem nftItem;

  const NftItemArgument(this.nftItem);
}
