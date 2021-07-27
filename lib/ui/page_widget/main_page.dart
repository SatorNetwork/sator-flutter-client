import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/ui/page_widget/home_page.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';
import 'package:satorio/ui/page_widget/shows_page.dart';
import 'package:satorio/ui/page_widget/some_page.dart';
import 'package:satorio/ui/page_widget/wallet_page.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _bodyContent[controller.selectedBottomTabIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedBottomTabIndex.value,
          onTap: (index) {
            switch (index) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                controller.toQrScanner();
                return;
              case 3:
                break;
              case 4:
                if (Get.isRegistered<WalletController>()) {
                  WalletController walletController = Get.find();
                  walletController.resetPageToInitValue();
                  walletController.refreshAllWallets();
                }
                break;
              default:
                break;
            }
            controller.selectedBottomTabIndex.value = index;
          },
          unselectedItemColor: SatorioColor.grey,
          fixedColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.videocam_rounded,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                SatorIcons.logo,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.image_rounded,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_rounded,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> _bodyContent = [
    HomePage(),
    ShowsPage(),
    QrScannerPage(),
    SomePage(),
    WalletPage(),
  ];
}
