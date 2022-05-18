import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/rss_list_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';
import 'package:webfeed/webfeed.dart';

class RssListPage extends GetView<RssListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_sator_blog'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              color: SatorioColor.darkAccent,
              size: 32,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          Container(
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: Colors.white,
            ),
            height: Get.mediaQuery.size.height -
                (Get.mediaQuery.padding.top + kToolbarHeight),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Obx(
                () => ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 24 * coefficient,
                  ),
                  itemCount: controller.rssItemsRx.value.length,
                  itemBuilder: (context, index) {
                    final RssItem rssItem = controller.rssItemsRx.value[index];
                    return _rssItemWithoutImage(rssItem);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _rssItemWithoutImage(RssItem rssItem) {
    return InkWell(
      onTap: () {
        controller.toRssItem(rssItem);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width - 2 * 20,
            padding: EdgeInsets.symmetric(
              horizontal: 24 * coefficient,
              vertical: 18 * coefficient,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              color: SatorioColor.alice_blue,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rssItem.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: textTheme.headline3!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 16 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 16 * coefficient,
                ),
                Text(
                  rssItem.content?.value.removeAllHtmlTags() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: textTheme.headline3!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width - 2 * 20,
            padding: EdgeInsets.symmetric(
              horizontal: 24 * coefficient,
              vertical: 20 * coefficient,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SatorioColor.alice_blue2, SatorioColor.alice_blue],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20 * coefficient,
                  height: 20 * coefficient,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        SatorioColor.yellow_orange,
                        SatorioColor.tomato,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 6 * coefficient,
                ),
                Expanded(
                  child: Text(
                    rssItem.author ?? (rssItem.dc?.creator ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rssItem(RssItem rssItem) {
    final double imageHeight = 135.0 * coefficient;
    return InkWell(
      onTap: () {
        controller.toRssItem(rssItem);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Image.network(
              rssItem.content!.images.first,
              height: imageHeight,
              width: Get.width - 2 * 20,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: Get.width - 2 * 20,
            padding: EdgeInsets.symmetric(
              horizontal: 24 * coefficient,
              vertical: 24 * coefficient,
            ),
            color: SatorioColor.alice_blue,
            child: Text(
              rssItem.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: textTheme.headline3!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 16 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: Get.width - 2 * 20,
            padding: EdgeInsets.symmetric(
              horizontal: 24 * coefficient,
              vertical: 20 * coefficient,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SatorioColor.alice_blue2, SatorioColor.alice_blue],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20 * coefficient,
                  height: 20 * coefficient,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        SatorioColor.yellow_orange,
                        SatorioColor.tomato,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 6 * coefficient,
                ),
                Expanded(
                  child: Text(
                    rssItem.author ?? (rssItem.dc?.creator ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
