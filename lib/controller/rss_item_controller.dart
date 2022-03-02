import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/ui/page_widget/web_page.dart';
import 'package:webfeed/webfeed.dart';

class RssItemController extends GetxController {
  late final RssItem rssItem;

  final PageController pageController = PageController();
  final RxDouble titleAlphaRx = 0.0.obs;

  RssItemController() {
    final RssItemArgument argument = Get.arguments as RssItemArgument;
    rssItem = argument.rssItem;
  }

  void back() {
    Get.back();
  }

  void toWebPage(String? url) {
    if (url != null)
      Get.to(
        () => WebPage(),
        binding: WebBinding(),
        arguments: WebArgument(
          url,
        ),
      );
  }
}

class RssItemArgument {
  final RssItem rssItem;

  const RssItemArgument(this.rssItem);
}
