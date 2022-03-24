import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:satorio/data/datasource/in_app_purchase_data_source.dart';

class InAppPurchaseDataSourceImpl implements InAppPurchaseDataSource {
  final FlutterInappPurchase _flutterInAppPurchase = FlutterInappPurchase
      .instance;

  @override
  Future<void> init() async {
    print('in app starting');
    List<String> products = ['sat_1'];
    List<IAPItem> packagesFromStores = [];

    try {
      await _flutterInAppPurchase.initialize().then((value) {
        print(value);
      });

      packagesFromStores =
      await _flutterInAppPurchase.getProducts(products);
      print(packagesFromStores.length);
      print(packagesFromStores);
    } catch (error) {
      print(error);
    }
  }
}
