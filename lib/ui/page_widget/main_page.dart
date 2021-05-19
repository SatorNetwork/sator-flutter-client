import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';
import 'package:satorio/ui/page_widget/home_page.dart';
import 'package:satorio/ui/page_widget/profile_page.dart';
import 'package:satorio/ui/page_widget/rewards_page.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _bodyContent[controller.selectedBottomTabIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedBottomTabIndex.value,
            onTap: (index) {
              controller.selectedBottomTabIndex.value = index;
            },
            unselectedItemColor: SatorioColor.darkAccent,
            fixedColor: SatorioColor.brand,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'txt_home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'txt_challenge'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'txt_profile'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assistant_photo),
                label: 'txt_rewards'.tr,
              ),
            ],
          )),
    );
  }

  final List<Widget> _bodyContent = [
    HomePage(),
    ChallengePage(),
    ProfilePage(),
    RewardsPage()
  ];
}
