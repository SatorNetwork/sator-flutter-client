import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/ui/page_widget/home_page.dart';
import 'package:satorio/ui/page_widget/shows_page.dart';
import 'package:satorio/ui/page_widget/some_page.dart';
import 'package:satorio/ui/page_widget/wallet_page.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/ext_bottom_navy_bar.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _bodyContent[controller.selectedBottomTabIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => ExtBottomNavyBar(
          selectedIndex: controller.selectedBottomTabIndex.value,
          showElevation: false,
          iconSize: 24,
          backgroundColor: Colors.white,
          itemCornerRadius: 14,
          animationDuration: Duration(milliseconds: 200),
          onItemSelected: (index) {
            controller.selectedBottomTabIndex.value = index;
            switch (index) {
              case MainController.TabScan:
                controller.toQrScanner();
                return;
              case MainController.TabWallet:
                if (Get.isRegistered<WalletController>()) {
                  WalletController walletController = Get.find();
                  walletController.resetPageToInitValue();
                  walletController.refreshAllWallets();
                }
                break;
              default:
                break;
            }
          },
          items: [
            ExtBottomNavyBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text(
                'txt_watch'.tr,
                style: textTheme.headline6!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              inactiveColor: SatorioColor.interactive,
              activeBackgroundColor: SatorioColor.interactive,
              activeColor: Colors.white,
            ),
            ExtBottomNavyBarItem(
              icon: Icon(Icons.videocam_rounded),
              title: Text(
                'txt_scan'.tr,
                style: textTheme.headline6!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              inactiveColor: SatorioColor.interactive,
              activeBackgroundColor: SatorioColor.interactive,
              activeColor: Colors.white,
            ),
            ExtBottomNavyBarItem(
              icon: Icon(SatorIcons.logo),
              title: Text(
                'txt_nfts'.tr,
                style: textTheme.headline6!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              inactiveColor: SatorioColor.interactive,
              activeBackgroundColor: SatorioColor.interactive,
              activeColor: Colors.white,
            ),
            ExtBottomNavyBarItem(
              icon: Icon(Icons.image_rounded),
              title: Text(
                'txt_wallet'.tr,
                style: textTheme.headline6!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              inactiveColor: SatorioColor.interactive,
              activeBackgroundColor: SatorioColor.interactive,
              activeColor: Colors.white,
            ),
            ExtBottomNavyBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              title: Text(
                'txt_profile'.tr,
                style: textTheme.headline6!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              inactiveColor: SatorioColor.interactive,
              activeBackgroundColor: SatorioColor.interactive,
              activeColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> _bodyContent = [
    HomePage(),
    EmptyPage(),
    ShowsPage(),
    WalletPage(),
    EmptyPage(),
  ];
}
