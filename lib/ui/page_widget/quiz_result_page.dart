import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QuizResultPage extends GetView<QuizResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.mediaQuery.padding.top + 22 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'txt_prize_pool'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 18.0 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controller.resultRx.value?.currentPrizePool ?? '',
                              textAlign: TextAlign.end,
                              style: textTheme.bodyText1!.copyWith(
                                color: SatorioColor.darkAccent,
                                fontSize: 18.0 * coefficient,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 21 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'txt_top_scores'.tr,
                      style: textTheme.headline4!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 24.0 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 21 * coefficient,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Obx(
                      () => ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black.withOpacity(0.10),
                          height: 1,
                        ),
                        itemCount:
                            controller.resultRx.value?.winners.length ?? 0,
                        itemBuilder: (context, index) {
                          final player =
                              controller.resultRx.value!.winners[index];
                          return _topPlayer(player);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 21 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'txt_other_players'.tr,
                      style: textTheme.headline4!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 24.0 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 21 * coefficient,
                  ),
                  Obx(
                    () => (controller.resultRx.value?.losers.isEmpty ?? true)
                        ? SizedBox(
                            height: 0,
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Obx(
                              () => ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 4,
                                ),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.black.withOpacity(0.10),
                                  height: 1,
                                ),
                                itemCount:
                                    controller.resultRx.value?.losers.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  final player =
                                      controller.resultRx.value!.losers[index];
                                  return _otherPlayer(player);
                                },
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 25 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedGradientButton(
                      text: 'txt_play_next_challenge'.tr,
                      onPressed: () {
                        controller.quizController.toChallenges();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 13 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BorderedButton(
                      text: 'txt_back_realm'.tr,
                      textColor: SatorioColor.darkAccent,
                      borderColor: SatorioColor.smalt.withOpacity(0.24),
                      onPressed: () {
                        controller.quizController.backToEpisode();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 38 * coefficient,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topPlayer(PayloadPlayer player) {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: AvatarImage(
              player.avatar,
              width: 34,
              height: 34,
            ),
          ),
          SizedBox(
            width: 20 * coefficient,
          ),
          Expanded(
            child: Text(
              player.username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText1!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 17.0 * coefficient,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              color: SatorioColor.interactive,
            ),
            child: Center(
              child: Text(
                player.prize,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontSize: 15.0 * coefficient,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _otherPlayer(PayloadPlayer player) {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: AvatarImage(
              player.avatar,
              width: 34,
              height: 34,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              player.username,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: SatorioColor.darkAccent,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
