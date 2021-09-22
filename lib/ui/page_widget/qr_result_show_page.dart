import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/qr_result_show_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QrResultShowPage extends GetView<QrResultShowController> {
  @override
  Widget build(BuildContext context) {
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
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 76 * coefficient),
              child: Column(
                children: [
                  Text(
                    "txt_watching".tr,
                    textAlign: TextAlign.center,
                    style: textTheme.headline1!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 34.0 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 34 * coefficient,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      height: 400 * coefficient,
                      width: Get.width - 40,
                      child: Obx(
                        () => Image.network(
                          controller.showRx.value.cover,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.showRx.value.title,
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.darkAccent,
                              fontSize: 18.0 * coefficient,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "txt_rewards_amount".tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 18.0 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          height: 36,
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: SatorioColor.interactive.withOpacity(0.2)),
                          child: Obx(
                            () => Text(
                              "${controller.qrShowRx.value.rewardAmount.toStringAsFixed(2)} SAO",
                              style: textTheme.bodyText1!.copyWith(
                                color: SatorioColor.interactive,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedGradientButton(
                        text: 'txt_claim_rewards'.tr,
                        isEnabled: !controller.isRequested.value,
                        onPressed: () {
                          controller.claimRewards();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () => controller.backToMain(),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.black.withOpacity(0.11), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'txt_back_home'.tr,
                              style: textTheme.bodyText1!.copyWith(
                                color: SatorioColor.darkAccent,
                                fontSize: 16.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
