import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/active_realms_controller.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ActiveRealmsPage extends GetView<ActiveRealmsController> {
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
          'txt_realms_open'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 24,
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
              top: kToolbarHeight + Get.mediaQuery.padding.top,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Stack(children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent)
                        controller.loadActivatedRealms();
                      return true;
                    },
                    child: _activeRealms(),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(1),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ])),
          )
        ],
      ),
    );
  }

  Widget _activeRealms() {
    return Obx(
      () => ListView.separated(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          itemCount: controller.activatedRealmsRx.value.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
          itemBuilder: (context, index) {
            return _realmItem(controller.activatedRealmsRx.value[index]!);
          }),
    );
  }

  Widget _realmItem(ActivatedRealm realm) {
    final double itemWidth = Get.width - 2 * 20 - 16 * coefficient;
    final double borderWidth = 5 * coefficient;

    return InkWell(
      onTap: () {
        controller.toEpisodeDetail(realm);
      },
      child: Container(
        width: itemWidth,
        height: 180 * coefficient,
        decoration: BoxDecoration(
          border: Border.all(
            color: SatorioColor.interactive,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16 * coefficient)),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(16 * coefficient - borderWidth)),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              CachedNetworkImage(
                imageUrl: realm.cover,
                cacheKey: realm.cover,
                width: Get.width,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: SatorioColor.darkAccent,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * coefficient - borderWidth,
                    vertical: 20 * coefficient - borderWidth,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        realm.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 18.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        realm.showTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontSize: 18.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
