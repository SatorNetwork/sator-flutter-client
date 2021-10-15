import 'package:get/get.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';

class ActiveRealmsController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<ActivatedRealm?>> activatedRealmsRx = Rx([]);

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  ActiveRealmsController() {
    loadActivatedRealms();
  }

  void loadActivatedRealms() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .getActivatedRealms(
      page: _pageRx.value,
      itemsPerPage: _itemsPerPage,
    )
        .then((List<ActivatedRealm> realms) {
      activatedRealmsRx.update((value) {
        if (value != null) value.addAll(realms);
      });
      _isAllLoadedRx.value = realms.isEmpty;
      _isLoadingRx.value = false;
      _pageRx.value = _pageRx.value + 1;
    }).catchError((value) {
      _isLoadingRx.value = false;
    });
  }

  void back() {
    Get.back();
  }
}