import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:satorio/data/datasource/in_app_purchase_data_source.dart';

class InAppPurchaseDataSourceImpl implements InAppPurchaseDataSource {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  @override
  Future<void> init() async {
  }
}
