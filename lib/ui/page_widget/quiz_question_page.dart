import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QuizQuestionPage extends GetView<QuizQuestionController> {
  static const double _margin = 20.0;
  static const double _itemSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    double questionsBlockSize = Get.width - 2 * _margin;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/gradient_challenge_timer.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: Get.mediaQuery.padding.top + 22, right: 16),
                child: TextButton(
                  onPressed: () {
                    controller.quizController.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: SatorioColor.alice_blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'txt_quit'.tr,
                    style: TextStyle(
                      color: SatorioColor.textBlack,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + 40,
                left: _margin,
                right: _margin,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: CircularCountDownTimer(
                        controller: controller.countdownController,
                        width: 119,
                        height: 119,
                        duration: controller.questionRx.value == null
                            ? 0
                            : controller.questionRx.value.timeForAnswer,
                        fillColor: SatorioColor.darkAccent,
                        ringColor: SatorioColor.brand,
                        isReverse: true,
                        backgroundColor: Colors.white,
                        strokeWidth: 7,
                        autoStart: true,
                        strokeCap: StrokeCap.round,
                        textFormat: CountdownTextFormat.S,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => Text(
                      controller.questionRx.value == null
                          ? ''
                          : '${controller.questionRx.value.questionNumber} / ${controller.questionRx.value.totalQuestions}',
                      style: TextStyle(
                        color: SatorioColor.darkAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Obx(
                          () => Text(
                            controller.questionRx.value == null
                                ? ''
                                : controller.questionRx.value.questionText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: SatorioColor.darkAccent,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: questionsBlockSize,
                    height: questionsBlockSize,
                    color: Colors.transparent,
                    child: Obx(
                      () => GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        crossAxisSpacing: _itemSpacing,
                        mainAxisSpacing: _itemSpacing,
                        children: controller.questionRx.value == null
                            ? []
                            : controller.questionRx.value.answerOptions
                                .map((e) => _answerWidget(e,
                                    e.answerId == controller.answerIdRx.value))
                                .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => ElevatedGradientButton(
                      text: 'txt_next'.tr,
                      isEnabled: controller.answerIdRx.value.isNotEmpty && !controller.isAnswerSentRx.value,
                      onPressed: () {
                        controller.sendAnswer();
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

  Widget _answerWidget(PayloadAnswerOption answerOption, bool isSelected) {
    return InkWell(
      onTap: () {
        controller.answerIdRx.value = answerOption.answerId;
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? SatorioColor.interactive : Colors.white,
        ),
        child: Center(
          child: Text(
            answerOption.answerText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
