import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';

class QuizCounterPage extends GetView<QuizCounterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
                () => SvgPicture.asset(
              _assetBackground(controller.countdownRx.value),
              height: Get.height,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Obx(
                  () => SvgPicture.asset(
                _assetCounterImage(controller.countdownRx.value),
                width: controller.countdownRx.value == 0
                    ? Get.width
                    : 0.35 * Get.width,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _assetBackground(int value) {
    if (value.isEven)
      return 'images/bg/gradient_challenge_splash_reversed.svg';
    else
      return 'images/bg/gradient_challenge_splash.svg';
  }

  String _assetCounterImage(int value) {
    switch (value) {
      case 3:
        return 'images/count_3.svg';
      case 2:
        return 'images/count_2.svg';
      case 1:
        return 'images/count_1.svg';
      case 0:
        return 'images/count_start.svg';
      default:
        return '';
    }
  }

}
