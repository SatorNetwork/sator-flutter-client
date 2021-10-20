import 'package:get/get.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';

class ActiveRealmsController extends GetxController {
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

  Future toEpisodeDetail(ActivatedRealm realm) async {
    ShowDetail showDetail = await _satorioRepository.showDetail(realm.showId);
    ShowEpisode showEpisode = await _satorioRepository.showEpisode(realm.showId, realm.id);

    Get.to(
      () => ShowEpisodesRealmPage(),
      binding: ShowEpisodesRealmBinding(),
      arguments: ShowEpisodeRealmArgument(
        showDetail,
        ShowSeason(realm.showId, realm.seasonNumber, realm.showTitle, []),
        showEpisode,
      ),
    );
  }

  void back() {
    Get.back();
  }
}
