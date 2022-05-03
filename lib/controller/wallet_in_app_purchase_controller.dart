import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/theme/light_theme.dart';

class WalletInAppPurchaseController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<IAPItem>> productsRx = Rx([]);
  final RxBool isExchangeRx = false.obs;

  late final StreamSubscription _purchaseUpdatedSubscription;
  late final StreamSubscription _purchaseErrorSubscription;
  late final StreamSubscription _connectionSubscription;

  WalletInAppPurchaseController() {
    _initializeInApp();
  }

  void back() {
    Get.back();
  }

  void toggle(bool isExchange) {
    isExchangeRx.value = isExchange;
  }

  Future<void> _initializeInApp() async {
    try {
      _satorioRepository.initializePurchase();

      _getInAppProducts();

      List<PurchasedItem>? purchasedList;

      if (productsRx.value.isNotEmpty) {
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

        print('transactionReceipt === ${product!.transactionReceipt!}');

        await verifyTransaction(
          data: product.transactionReceipt!,
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
      print(ids);
      if (ids == null) return;

      _satorioRepository.getProducts(["sat1"]).then((value) {
        productsRx.value = value;
      });
    });
  }

  Future<void> buyInAppProduct(String id) async {
    if (id.isEmpty) return;

    _satorioRepository.buyInAppProduct(id);
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
        //TODO: add response after API callback
        Get.back();
      }
    }).catchError((error) {
      //TODO: remove after tests and add response after API callback
      print(error);
    });
  }
}
