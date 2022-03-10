import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/rss_item_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class RssItemPage extends GetView<RssItemController> {
  get _appBarHeight => 370 * coefficient;

  get _hasImages =>
      controller.rssItem.content != null &&
      controller.rssItem.content!.images.isNotEmpty;

  final Rx<Color> backBgColor = Rx(Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: _appBarHeight + Get.mediaQuery.padding.top + 32,
            width: Get.width,
            child: Image.network(
              controller.rssItem.content!.images.first,
              width: Get.width,
              height: _appBarHeight + Get.mediaQuery.padding.top + 32,
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              backBgColor.value = notification.metrics.pixels <=
                      _appBarHeight - kToolbarHeight / 2
                  ? Colors.white
                  : Colors.transparent;
              return false;
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  expandedHeight: _appBarHeight,
                  collapsedHeight: kToolbarHeight,
                  // floating: true,
                  pinned: true,
                  leading: Obx(
                    () => Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: backBgColor.value,
                      ),
                      child: InkWell(
                        onTap: () => controller.back(),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: 32,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.rssItem.pubDate == null
                                  ? ''
                                  : '${DateFormat('MMMM d, yyyy').format(controller.rssItem.pubDate!)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: textTheme.bodyText2!.copyWith(
                                color: Colors.black,
                                fontSize: 12 * coefficient,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 11 * coefficient,
                            ),
                            Text(
                              controller.rssItem.title ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: textTheme.headline3!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 28 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 14 * coefficient,
                            ),
                            Row(
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
                                  width: 10 * coefficient,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.rssItem.author ??
                                        (controller.rssItem.dc?.creator ?? ''),
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
                            SizedBox(height: 30 * coefficient),
                            Html(
                              data: controller.rssItem.content?.value ?? '',
                              onLinkTap: (url, context, attributes, element) {
                                controller.toWebPage(url);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
