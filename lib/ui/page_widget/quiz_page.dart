import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';

class QuizPage extends GetView<QuizController> {
  QuizPage(Challenge challenge) : super() {
    controller.setChallenge(challenge);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _childPageWidget(controller.childPageWidget.value));
  }

  Widget _childPageWidget(String pageType) {
    switch (pageType) {
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}
