import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/data/connectivity/internet_connectivity.dart';

mixin ConnectivityMixin on GetxController {
  final ValueNotifier<bool> _notifier =
      Get.find<InternetConnectivity>().internetConnectivity();

  RxBool isInternetConnectedRx = true.obs;

  @override
  void onInit() {
    _connectivityListener();
    _notifier.addListener(_connectivityListener);
    super.onInit();
  }

  @override
  void onClose() {
    _notifier.removeListener(_connectivityListener);
    super.onClose();
  }

  void _connectivityListener() {
    isInternetConnectedRx.value = _notifier.value;
  }
}
