import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/shows_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ShowsPage extends GetView<ShowsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/shows.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            NotificationListener<OverscrollNotification>(
              onNotification: (notification) {
                // TODO : finish logic with pagination
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) print('Next Page');
                return true;
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
                            style: TextStyle(
                                color: SatorioColor.darkAccent,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                          color: Colors.white,
                        ),
                        constraints: BoxConstraints(
                          minHeight: Get.height -
                              kBottomNavigationBarHeight -
                              kToolbarHeight -
                              Get.mediaQuery.padding.top,
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
            )
          ],
        ),
      ),
    );
  }

  Widget _showItem(Show show) {
    return InkWell(
      onTap: () {
        controller.toShowChallenges(show);
      },
      child: Container(
        height: 168,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage(show.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        show.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
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
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
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
    );
  }
}
