import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:satorio/controller/wallet_receive_controller.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class WalletReceivePage extends GetView<WalletReceiveController> {
  static const double _kHeight = 120;

  WalletReceivePage(WalletDetail walletDetail) {
    controller.walletDetailRx.value = walletDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/bg/gradient.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            height: _kHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Positioned(
                    top: _kHeight / 2,
                    child: InkWell(
                      onTap: () => controller.back(),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 32,
                        color: SatorioColor.darkAccent,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _kHeight / 1.8),
                    width: Get.mediaQuery.size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'txt_receive'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: Get.mediaQuery.size.height - _kHeight,
            ),
            margin: EdgeInsets.only(top: _kHeight),
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
                    data:
                        controller.walletDetailRx.value?.solanaAccountAddress ??
                            '',
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
                    controller.walletDetailRx.value?.solanaAccountAddress ?? '',
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
