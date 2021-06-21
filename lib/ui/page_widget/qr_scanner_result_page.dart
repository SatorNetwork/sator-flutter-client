import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/qr_scanner_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QrScannerResultPage extends GetView<QrScannerController> {
  QrScannerResultPage(String qrId) : super() {
    controller.getShowEpisodeByQR(qrId);
  }

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
              margin: EdgeInsets.only(top: 76),
              child: Column(
                children: [
                  Text(
                    "txt_watching".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 34.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Obx(
                      () => ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                          height: 400,
                          width: Get.width - 40,
                          child: Image.network(
                            controller.showRx.value!.cover,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                      () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.showRx.value!.title,
                              style: TextStyle(
                                color: SatorioColor.darkAccent,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Obx(
                        () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("txt_rewards_amount".tr,
                              style: TextStyle(
                                color: SatorioColor.darkAccent,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              )),
                          Container(
                            height: 36,
                            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: SatorioColor.interactive.withOpacity(0.2)),
                            child: Text(
                              "${
                                controller.qrResultRx.value!.rewardAmount
                                    .toString()
                              } SAO",
                              style: TextStyle(
                                color: SatorioColor.interactive,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
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
                              style: TextStyle(
                                color: SatorioColor.darkAccent,
                                fontSize: 16.0,
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
