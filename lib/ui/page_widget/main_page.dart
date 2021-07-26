import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/ui/page_widget/home_page.dart';
import 'package:satorio/ui/page_widget/shows_page.dart';
import 'package:satorio/ui/page_widget/some_page.dart';
import 'package:satorio/ui/page_widget/wallet_page.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _bodyContent[controller.selectedBottomTabIndex.value],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        width: Get.width,
        child: GNav(
          selectedIndex: controller.selectedBottomTabIndex.value,
          gap: 8,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          activeColor: Colors.white,
          color: SatorioColor.interactive,
          tabBorderRadius: 14,
          duration: Duration(milliseconds: 500),
          iconSize: 24,
          textStyle: textTheme.headline6!.copyWith(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          tabBackgroundColor: SatorioColor.interactive,
          tabs: [
            GButton(
              icon: Icons.home_rounded,
              text: 'txt_watch'.tr,
            ),
            GButton(
              icon: Icons.videocam_rounded,
              text: 'txt_scan'.tr,
              onPressed: () {
                controller.toQrScanner();
                // final int v = controller.selectedBottomTabIndex.value;
                // print('onPressed $v');
              },
            ),
            GButton(
              icon: SatorIcons.logo,
              text: 'txt_nfts'.tr,
            ),
            GButton(
              icon: Icons.image_rounded,
              text: 'txt_wallet'.tr,
              onPressed: () {
                if (Get.isRegistered<WalletController>()) {
                  WalletController walletController = Get.find();
                  walletController.resetPageToInitValue();
                  walletController.refreshAllWallets();
                }
              },
            ),
            GButton(
              icon: Icons.account_balance_wallet_rounded,
              text: 'txt_profile'.tr,
            ),
          ],
          onTabChange: (index) {
            controller.selectedBottomTabIndex.value = index;
            // print('${controller.selectedBottomTabIndex.value}');
          },
        ),
      ),

      // bottomNavigationBar: Obx(
      //   () => BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: controller.selectedBottomTabIndex.value,
      //     onTap: (index) {
      //       switch (index) {
      //         case 0:
      //           break;
      //         case 1:
      //           break;
      //         case 2:
      //           controller.toQrScanner();
      //           return;
      //         case 3:
      //           break;
      //         case 4:
      //           if (Get.isRegistered<WalletController>()) {
      //             WalletController walletController = Get.find();
      //             walletController.resetPageToInitValue();
      //             walletController.refreshAllWallets();
      //           }
      //           break;
      //         default:
      //           break;
      //       }
      //       controller.selectedBottomTabIndex.value = index;
      //     },
      //     unselectedItemColor: SatorioColor.grey,
      //     fixedColor: Colors.black,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home_rounded,
      //         ),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.videocam_rounded,
      //         ),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           SatorIcons.logo,
      //         ),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.image_rounded,
      //         ),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.account_balance_wallet_rounded,
      //         ),
      //         label: '',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  final List<Widget> _bodyContent = [
    HomePage(),
    SomePage(),
    ShowsPage(),
    WalletPage(),
    SomePage(),
  ];
}
