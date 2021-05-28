import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';

class QuizPage extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => _childPageWidget(controller.childPageWidget.value));
  }

  Widget _childPageWidget(String pageType) {
    switch(pageType) {
      default:
        return Container();
    }
  }

}