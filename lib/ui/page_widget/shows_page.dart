import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/shows_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ShowsPage extends GetView<ShowsController> {
  @override
  Widget build(BuildContext context) {
    const double kHeight = 120;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/gradient.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            NotificationListener<OverscrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent)
                  controller.loadShows();
                return true;
              },
              child: RefreshIndicator(
                color: SatorioColor.brand,
                onRefresh: () async {
                  controller.loadShows();
                },
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: Center(
                            child: Text(
                              'txt_challenges'.tr,
                              style: textTheme.headline4!.copyWith(
                                color: SatorioColor.darkAccent,
                                fontSize: 28.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            color: Colors.white,
                          ),
                          constraints: BoxConstraints(
                            minHeight: Get.mediaQuery.size.height - kHeight,
                          ),
                          child: Obx(
                            () => ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(24),
                              physics: ScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 24,
                              ),
                              itemCount: controller.showsRx.value.length,
                              itemBuilder: (context, index) {
                                Show show = controller.showsRx.value[index];
                                return _showItem(show);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showItem(Show show) {
    return InkWell(
      onTap: () {
        controller.toShowDetail(show);
      },
      onLongPress: () {
        controller.toShowChallenges(show);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 168 * coefficient,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                child: Image(
                  image: NetworkImage(show.cover),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: SatorioColor.grey,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          show.title,
                          style: textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontSize: 20.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      show.hasNewEpisode
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: SatorioColor.lavender_rose,
                              ),
                              child: Text(
                                'txt_new'.tr.toUpperCase(),
                                style: textTheme.bodyText2!.copyWith(
                                  color: Colors.black,
                                  fontSize: 12.0 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
