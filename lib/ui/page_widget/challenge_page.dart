import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ChallengePage extends GetView<ChallengeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_challenge'.tr,
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
              color: SatorioColor.darkAccent,
              size: 32,
            ),
          ),
        ),
      ),
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
              margin: EdgeInsets.only(
                  top: Get.mediaQuery.padding.top + kToolbarHeight),
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
                      textAlign: TextAlign.center,
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
                  SizedBox(height: 25),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          _blockTitle(controller.challengeRx.value),
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 15.0 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _blockValue(controller.challengeRx.value),
                            textAlign: TextAlign.end,
                            style: textTheme.bodyText1!.copyWith(
                              color: _blockValueTextColor(
                                  controller.challengeRx.value),
                              fontSize: 15.0 * coefficient,
                              fontWeight: _blockValueTextWeight(
                                  controller.challengeRx.value),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45),
                  Obx(
                    () => ElevatedGradientButton(
                      text: _buttonText(controller.challengeRx.value),
                      isInProgress: controller.isRequested.value,
                      onPressed: () {
                        _buttonClick(controller.challengeRx.value);
                        // controller.playChallenge();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _blockTitle(Challenge? challenge) {
    if (challenge == null)
      return '';
    else if (challenge.receivedReward != 0)
      return 'txt_you_earned'.tr;
    else
      return 'txt_attempts_left'.tr;
  }

  String _blockValue(Challenge? challenge) {
    if (challenge == null)
      return '';
    else if (challenge.receivedReward != 0)
      return challenge.receivedRewardAsString;
    else
      return '${controller.challengeRx.value!.attemptsLeft} / ${controller.challengeRx.value!.userMaxAttempts}';
  }

  Color _blockValueTextColor(Challenge? challenge) {
    if (challenge == null)
      return SatorioColor.textBlack;
    else if (challenge.receivedReward != 0 || challenge.attemptsLeft != 0)
      return SatorioColor.textBlack;
    else
      return SatorioColor.error;
  }

  FontWeight _blockValueTextWeight(Challenge? challenge) {
    if (challenge == null)
      return FontWeight.w400;
    else if (challenge.receivedReward != 0 || challenge.attemptsLeft != 0)
      return FontWeight.w400;
    else
      return FontWeight.w700;
  }

  String _buttonText(Challenge? challenge) {
    if (challenge == null)
      return '';
    else if (challenge.attemptsLeft == 0 || challenge.receivedReward != 0)
      return 'txt_back_realm'.tr;
    else
      return 'txt_play'.tr;
  }

  void _buttonClick(Challenge? challenge) {
    if (challenge == null) {
      // nothing...
    } else if (challenge.attemptsLeft == 0 || challenge.receivedReward != 0) {
      controller.back();
    } else {
      controller.playChallenge();
    }
  }
}
