import 'package:get/get.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class NFTsController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> allShowsRx = Rx([]);

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  @override
  void onInit() {
    super.onInit();
    _loadAllShows();
  }

  void _loadAllShows() {
    _satorioRepository.shows(page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      allShowsRx.value = shows;
    });
  }
}
