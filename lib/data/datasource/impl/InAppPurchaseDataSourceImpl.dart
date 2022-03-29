import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:satorio/data/datasource/in_app_purchase_data_source.dart';

class InAppPurchaseDataSourceImpl implements InAppPurchaseDataSource {
  final FlutterInappPurchase _inAppPurchase = FlutterInappPurchase.instance;

  @override
  Future<void> init() async {}

  @override
  Future<List<IAPItem>> getProducts(List<String> productsIds) {
    return _inAppPurchase.getProducts(productsIds);
  }

  @override
  Future<void> buyInAppProduct(String id) {
    return _inAppPurchase.requestPurchase(id);
  }

  @override
  Future<String?> initializePurchase() async {
    return await _inAppPurchase.initialize();
  }

  @override
  Future<List<PurchasedItem>?> purchaseHistory() async {
    return await _inAppPurchase.getPurchaseHistory();
  }

  @override
  Future<void> consumeAll() {
    return _inAppPurchase.consumeAll();
  }

  @override
  Future<String?> finishTransaction(
      PurchasedItem purchasedItem, bool isConsumable) {
    return _inAppPurchase.finishTransaction(purchasedItem,
        isConsumable: isConsumable);
  }
}
