import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/personal_profile_controller.dart';
import 'package:satorio/ui/page_widget/activity_page.dart';
import 'package:satorio/ui/page_widget/empty_page.dart';
import 'package:satorio/ui/page_widget/profile_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class PersonalProfilePage extends GetView<PersonalProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: SatorioColor.textBlack,
          ),
          onPressed: () {
            controller.toSettings();
          },
        ),
        actions: [
          Container(
            width: kToolbarHeight,
            height: kToolbarHeight,
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: SatorioColor.textBlack,
                  ),
                  onPressed: () {
                    controller.toNotificationSettings();
                  },
                ),
                Positioned(
                  right: 22,
                  top: 14,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SatorioColor.brand,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: SatorioColor.textBlack,
          labelColor: SatorioColor.textBlack,
          unselectedLabelColor: SatorioColor.textBlack.withOpacity(0.7),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: SatorioColor.textBlack, width: 2),
            insets: EdgeInsets.symmetric(horizontal: 20),
          ),
          labelStyle: textTheme.headline5!.copyWith(
            color: SatorioColor.textBlack,
            fontSize: 20 * coefficient,
            fontWeight: FontWeight.w700,
          ),
          tabs: [
            Tab(
              text: 'txt_profile'.tr,
            ),
            Tab(
              text: 'txt_activity'.tr,
            ),
            Tab(
              text: 'txt_friends'.tr,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          Container(
            margin: EdgeInsets.only(
              top: Get.mediaQuery.padding.top +
                  kToolbarHeight +
                  kTextTabBarHeight,
            ),
            width: Get.width,
            child: TabBarView(
              controller: controller.tabController,
              children: [
                ProfilePage(),
                ActivityPage(),
                EmptyPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
