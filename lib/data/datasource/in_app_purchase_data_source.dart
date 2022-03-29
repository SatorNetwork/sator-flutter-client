import 'package:flutter_inapp_purchase/modules.dart';

abstract class InAppPurchaseDataSource {
  Future<void> init();

  Future<List<IAPItem>> getProducts(List<String> productsIds);

  Future<void> buyInAppProduct(String id);

  Future<String?> initializePurchase();

  Future<List<PurchasedItem>?> purchaseHistory();

  Future<void> consumeAll();

  Future<String?> finishTransaction(
      PurchasedItem purchasedItem, bool isConsumable);
}
