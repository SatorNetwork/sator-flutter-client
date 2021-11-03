import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';

class ShowEpisodeQuizPage extends GetView<ShowEpisodeQuizController> {
  static const double _margin = 20.0;
  static const double _itemSpacing = 12.0;

  final double answersBlockSize = isMaxScreenWidth ? Get.height / 2 : Get.width - 2 * _margin;
  final double answerSize = (Get.width - 2 * _margin - _itemSpacing) / 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/gradient_challenge_timer.svg',
              height: isMaxScreenWidth ? null : Get.height,
              width: isMaxScreenWidth ? Get.width : null,
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
                    child: Obx(
                      () => controller.questionRx.value.questionText.isLink()
                          ? _imageQuestion()
                          : _textQuestion(),
                    ),
                  ),
                  Container(
                    width: answersBlockSize,
                    height: answersBlockSize,
                    color: Colors.transparent,
                    child: Obx(
                      () => _answersListWidget(
                        controller.questionRx.value.answerOptions,
                        controller.answerIdRx.value,
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
                    controller.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: SatorioColor.alice_blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'txt_cancel'.tr,
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
        _episodeName(),
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
                      controller.questionRx.value.questionText,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0 * coefficient),
                    child: Obx(
                      () => CircularCountDownTimer(
                        controller: controller.countdownController,
                        width: 48 * coefficient,
                        height: 48 * coefficient,
                        duration: controller.questionRx.value.timeForAnswer,
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
                        onComplete: () {
                          controller.timeExpire();
                        },
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
            child: Obx(
              () => CircularCountDownTimer(
                controller: controller.countdownController,
                width: 119 * coefficient,
                height: 119 * coefficient,
                duration: controller.questionRx.value.timeForAnswer,
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
                onComplete: () {
                  controller.timeExpire();
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        _episodeName(),
        Expanded(
          child: Container(
            child: Center(
              child: Obx(
                () => Text(
                  controller.questionRx.value.questionText,
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

  Widget _answersListWidget(
    List<PayloadAnswerOption> answerOptions,
    String answerId,
  ) {
    switch (answerOptions.length) {
      case 2:
        return Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: _itemSpacing,
              mainAxisSpacing: _itemSpacing,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: answerOptions.length,
            itemBuilder: (BuildContext context, int index) {
              PayloadAnswerOption answerOption = answerOptions[index];
              bool isSelected = answerOption.answerId == answerId;
              return _answerWidget(answerOption, isSelected);
            },
          ),
        );
      case 3:
        return StaggeredGridView.countBuilder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          crossAxisSpacing: _itemSpacing,
          mainAxisSpacing: _itemSpacing,
          staggeredTileBuilder: (index) =>
              StaggeredTile.count(index == answerOptions.length - 1 ? 2 : 1, 1),
          itemCount: answerOptions.length,
          itemBuilder: (context, index) {
            PayloadAnswerOption answerOption = answerOptions[index];
            bool isSelected = answerOption.answerId == answerId;
            return index == answerOptions.length - 1
                ? Container(
                    child: Center(
                      child: _answerWidget(answerOption, isSelected),
                    ),
                  )
                : _answerWidget(answerOption, isSelected);
          },
        );
      case 4:
      default:
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: _itemSpacing,
            mainAxisSpacing: _itemSpacing,
          ),
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: answerOptions.length,
          itemBuilder: (BuildContext context, int index) {
            PayloadAnswerOption answerOption = answerOptions[index];
            bool isSelected = answerOption.answerId == answerId;
            return _answerWidget(answerOption, isSelected);
          },
        );
    }
  }

  Widget _answerWidget(PayloadAnswerOption answerOption, bool isSelected) {
    return InkWell(
      onTap: () {
        controller.selectAnswer(answerOption);
      },
      child: Container(
        width: answerSize,
        height: answerSize,
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

  //
  Widget _episodeName() {
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
          controller.showSeasonRx.value.seasonNumber == 0
              ? ''
              : 'txt_episode_entrance_quiz'.tr.format(
                  [
                    controller.showSeasonRx.value.seasonNumber,
                    controller.showEpisodeRx.value.episodeNumber,
                  ],
                ),
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
