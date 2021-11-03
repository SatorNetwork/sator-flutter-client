import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/domain/entities/payload/payload_winner.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QuizResultPage extends GetView<QuizResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            backgroundImage,
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 76),
              child: Column(
                children: [
                  Text(
                    "txt_winners".tr,
                    textAlign: TextAlign.center,
                    style: textTheme.headline1!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 34.0 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "txt_prize_pool".tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 18.0 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.resultRx.value?.prizePool ?? '',
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.darkAccent,
                              fontSize: 18.0 * coefficient,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.white),
                      child: Obx(
                        () => ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            separatorBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Divider(
                                    color: Colors.black.withOpacity(0.1),
                                    height: 1,
                                  ),
                                ),
                            itemCount:
                                controller.resultRx.value?.winners.length ?? 0,
                            itemBuilder: (context, index) {
                              PayloadWinner payloadWinner =
                                  controller.resultRx.value!.winners[index];
                              return _winnerItem(payloadWinner);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24 * coefficient,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => ElevatedGradientButton(
                        text: 'txt_claim_rewards'.tr,
                        isInProgress: controller.isRequested.value,
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedGradientButton(
                      text: 'txt_back_realm'.tr,
                      onPressed: () {
                        controller.quizController.backToEpisode();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _winnerItem(PayloadWinner payloadWinner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            payloadWinner.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyText1!.copyWith(
              color: SatorioColor.textBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 33,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(56)),
              color: SatorioColor.interactive),
          child: Center(
            child: Text(
              payloadWinner.prize,
              style: textTheme.bodyText2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
