import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/challenge_detail_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ChallengeDetailPage extends GetView<ChallengeDetailController> {
  ChallengeDetailPage(String challengeId) : super() {
    controller.loadChallengeDetail(challengeId);
  }

  @override
  Widget build(BuildContext context) {
    const double kHeight = 120;

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
            Stack(
              children: [
                Container(
                  height: kHeight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    child: Stack(
                      children: [
                        Positioned(
                          top: kHeight / 2,
                          child: InkWell(
                            onTap: () => controller.back(),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 32,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: kHeight / 1.8),
                          width: Get.mediaQuery.size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'txt_challenge'.tr,
                                style: TextStyle(
                                  color: SatorioColor.darkAccent,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.only(top: 120),
                  padding: const EdgeInsets.only(top: 57, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: SatorioColor.lavender_rose,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'images/challenge_tracery.svg',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Obx(
                        () => Text(
                          controller.challengeDetailRx.value == null
                              ? ''
                              : controller.challengeDetailRx.value.title,
                          style: TextStyle(
                            color: SatorioColor.darkAccent,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => Text(
                          controller.challengeDetailRx.value == null
                              ? ''
                              : controller.challengeDetailRx.value.description,
                          style: TextStyle(
                            color: SatorioColor.manatee,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Row(
                        children: [
                          Text(
                            'txt_prize_pool'.tr,
                            style: TextStyle(
                              color: SatorioColor.textBlack,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.challengeDetailRx.value == null
                                    ? ''
                                    : controller
                                        .challengeDetailRx.value.prizePool,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: SatorioColor.textBlack,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'txt_winners'.tr,
                            style: TextStyle(
                              color: SatorioColor.textBlack,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.challengeDetailRx.value == null ||
                                        controller.challengeDetailRx.value
                                            .winners.isEmpty
                                    ? '--'
                                    : controller
                                        .challengeDetailRx.value.winners,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: SatorioColor.textBlack,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'txt_players'.tr,
                            style: TextStyle(
                              color: SatorioColor.textBlack,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.challengeDetailRx.value == null
                                    ? ''
                                    : '${0} / ${controller.challengeDetailRx.value.players}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: SatorioColor.textBlack,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 45),
                      ElevatedGradientButton(
                        text: 'txt_play'.tr,
                        onPressed: () {
                          controller.playChallenge();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
