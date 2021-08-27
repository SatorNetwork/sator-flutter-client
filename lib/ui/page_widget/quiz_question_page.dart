import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';

class QuizQuestionPage extends GetView<QuizQuestionController> {
  static const double _margin = 20.0;
  static const double _itemSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    double questionsBlockSize = (Get.width - 2 * _margin) * coefficient;

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
            Container(
              margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top,
                left: _margin,
                right: _margin,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(() =>
                        (controller.questionRx.value?.questionText ?? '')
                                .isLink()
                            ? _imageQuestion()
                            : _textQuestion()),
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
                            : controller.questionRx.value!.answerOptions
                                .map((answerOption) => _answerWidget(
                                    answerOption,
                                    answerOption.answerId ==
                                        controller.answerIdRx.value))
                                .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: Get.mediaQuery.padding.top + 6, right: 16),
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
                    style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 18.0 * coefficient,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
        ),
        _questionNumber(),
        SizedBox(
          height: 12 * coefficient,
        ),
        Expanded(
          child: Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12 * coefficient),
                  child: Obx(
                    () => Image.network(
                      controller.questionRx.value?.questionText ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0 * coefficient),
                    child: Obx(
                      () => controller.questionRx.value == null
                          ? Container(
                              width: 48 * coefficient,
                              height: 48 * coefficient,
                            )
                          : CircularCountDownTimer(
                              controller: controller.countdownController,
                              width: 48 * coefficient,
                              height: 48 * coefficient,
                              duration:
                                  controller.questionRx.value?.timeForAnswer ??
                                      0,
                              fillColor: SatorioColor.darkAccent,
                              ringColor: SatorioColor.brand,
                              isReverse: true,
                              backgroundColor: Colors.white,
                              strokeWidth: 3,
                              autoStart: true,
                              strokeCap: StrokeCap.round,
                              textFormat: CountdownTextFormat.S,
                              textStyle: textTheme.headline1!.copyWith(
                                color: Colors.black,
                                fontSize: 18.0 * coefficient,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24 * coefficient,
        ),
      ],
    );
  }

  Widget _textQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24,
        ),
        Container(
          child: Center(
            child: CircularCountDownTimer(
              controller: controller.countdownController,
              width: 119 * coefficient,
              height: 119 * coefficient,
              duration: controller.questionRx.value?.timeForAnswer ?? 0,
              fillColor: SatorioColor.darkAccent,
              ringColor: SatorioColor.brand,
              isReverse: true,
              backgroundColor: Colors.white,
              strokeWidth: 7,
              autoStart: true,
              strokeCap: StrokeCap.round,
              textFormat: CountdownTextFormat.S,
              textStyle: textTheme.headline1!.copyWith(
                color: Colors.black,
                fontSize: 45.0 * coefficient,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        _questionNumber(),
        Expanded(
          child: Container(
            child: Center(
              child: Obx(
                () => Text(
                  controller.questionRx.value?.questionText ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.headline2!.copyWith(
                    color: SatorioColor.darkAccent,
                    fontSize: 24.0 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _answerWidget(PayloadAnswerOption answerOption, bool isSelected) {
    return InkWell(
      onTap: () {
        controller.selectAnswer(answerOption);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? SatorioColor.interactive : Colors.white,
        ),
        child: answerOption.answerText.isLink()
            ? Image.network(
                answerOption.answerText,
                fit: BoxFit.cover,
              )
            : Center(
                child: Text(
                  answerOption.answerText,
                  textAlign: TextAlign.center,
                  style: textTheme.headline4!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 20.0 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _questionNumber() {
    return Container(
      constraints: BoxConstraints(minHeight: 30 * coefficient),
      padding: EdgeInsets.symmetric(
        vertical: 4 * coefficient,
        horizontal: 12 * coefficient,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * coefficient),
        color: Colors.white,
      ),
      child: Obx(
        () => Text(
          controller.questionRx.value == null
              ? ''
              : '${controller.questionRx.value!.questionNumber} / ${controller.questionRx.value!.totalQuestions}',
          style: TextStyle(
            color: SatorioColor.darkAccent,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 2,
        ),
      ),
    );
  }
}
