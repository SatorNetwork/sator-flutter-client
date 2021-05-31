import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/ui/page_widget/quiz_counter_page.dart';
import 'package:satorio/ui/page_widget/quiz_lobby_page.dart';

class QuizPage extends GetView<QuizController> {
  QuizPage(Challenge challenge) : super() {
    controller.setChallenge(challenge);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _childPageWidget(controller.screenTypeRx.value));
  }

  Widget _childPageWidget(QuizScreenType screenType) {
    switch (screenType) {
      case QuizScreenType.lobby:
        return QuizLobbyPage();
      case QuizScreenType.countdown:
        return QuizCounterPage();
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}
