import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ChallengePage extends GetView<ChallengeController> {
  ChallengePage(String challengeId) : super() {
    controller.loadChallenge(challengeId);
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
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.darkAccent,
                              fontSize: 17,
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
                    width: 100 * coefficient,
                    height: 100 * coefficient,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SatorioColor.lavender_rose,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'images/sator_logo.svg',
                        color: Colors.white,
                        width: 40 * coefficient,
                        height: 40 * coefficient,
                      ),
                    ),
                  ),
                  SizedBox(height: 48 * coefficient),
                  Obx(
                    () => Text(
                      controller.challengeRx.value?.title ?? '',
                      style: textTheme.headline1!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 32.0 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(
                    () => Text(
                      controller.challengeRx.value?.description ?? '',
                      style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.manatee,
                        fontSize: 15.0 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 48),
                  Row(
                    children: [
                      Text(
                        'txt_prize_pool'.tr,
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            controller.challengeRx.value?.prizePool ?? '',
                            textAlign: TextAlign.end,
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 15.0 * coefficient,
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
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            controller.challengeRx.value == null ||
                                    controller
                                        .challengeRx.value!.winners.isEmpty
                                ? '--'
                                : controller.challengeRx.value!.winners,
                            textAlign: TextAlign.end,
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 15.0 * coefficient,
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
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            controller.challengeRx.value == null
                                ? ''
                                : '${0} / ${controller.challengeRx.value!.players}',
                            textAlign: TextAlign.end,
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 15.0 * coefficient,
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
            ),
          ],
        ),
      ),
    );
  }
}
