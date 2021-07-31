import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/ui/page_widget/quiz_counter_page.dart';
import 'package:satorio/ui/page_widget/quiz_lobby_page.dart';
import 'package:satorio/ui/page_widget/quiz_question_page.dart';
import 'package:satorio/ui/page_widget/quiz_result_page.dart';

class QuizPage extends GetView<QuizController> {
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
      case QuizScreenType.question:
        return QuizQuestionPage();
      case QuizScreenType.result:
        return QuizResultPage();
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}
