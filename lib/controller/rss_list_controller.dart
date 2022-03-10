import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/rss_item_binding.dart';
import 'package:satorio/controller/rss_item_controller.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/rss_item_page.dart';
import 'package:webfeed/webfeed.dart';

class RssListController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late ValueListenable<Box<RssItem>> _rssItemsListenable;

  final Rx<List<RssItem>> rssItemsRx = Rx([]);

  RssListController() {
    _rssItemsListenable = _satorioRepository.rssItemsListenable()
        as ValueListenable<Box<RssItem>>;
  }

  @override
  void onInit() {
    super.onInit();
    _rssItemsListenable.addListener(_rssItemsListener);

    _satorioRepository.updateRssItems();
  }

  @override
  void onClose() {
    _rssItemsListenable.removeListener(_rssItemsListener);
    super.onClose();
  }

  void back() {
    Get.back();
  }

  void _rssItemsListener() {
    rssItemsRx.value = _rssItemsListenable.value.values.toList();
  }

  void toRssItem(RssItem rssItem) {
    Get.to(
      () => RssItemPage(),
      binding: RssItemBinding(),
      arguments: RssItemArgument(rssItem),
    );
  }
}
