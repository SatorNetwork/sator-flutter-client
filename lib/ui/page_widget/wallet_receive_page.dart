import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:satorio/controller/wallet_receive_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class WalletReceivePage extends GetView<WalletReceiveController> {
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
          'txt_receive'.tr,
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
              size: 32,
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/bg/gradient.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: Get.mediaQuery.size.height -
                  (Get.mediaQuery.padding.top + kToolbarHeight),
            ),
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.profileRx.value?.displayedName ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                      fontSize: 18 * coefficient,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
                Obx(
                  () => QrImage(
                    data: controller.qrCodeDataRx.value,
                    size: 0.64 * Get.width,
                  ),
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
                ElevatedGradientButton(
                  text: 'txt_share_qr'.tr,
                  onPressed: () {
                    controller.shareQr();
                  },
                ),
                SizedBox(
                  height: 48 * coefficient,
                ),
                Text(
                  'txt_account_address'.tr,
                  textAlign: TextAlign.center,
                  style: textTheme.headline6!.copyWith(
                    color: SatorioColor.bright_grey,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8 * coefficient,
                ),
                Obx(
                  () => Text(
                    controller.walletDetailRx.value.solanaAccountAddress,
                    textAlign: TextAlign.center,
                    style: textTheme.headline6!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8 * coefficient,
                ),
                InkWell(
                  onTap: () {
                    controller.copyAddress();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8 * coefficient),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.file_copy_rounded,
                          size: 16 * coefficient,
                          color: SatorioColor.interactive,
                        ),
                        SizedBox(
                          width: 9 * coefficient,
                        ),
                        Text(
                          'txt_copy_address'.tr,
                          textAlign: TextAlign.center,
                          style: textTheme.headline6!.copyWith(
                            color: SatorioColor.interactive,
                            fontSize: 14 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
