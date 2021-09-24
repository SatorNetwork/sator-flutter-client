import 'package:get/get.dart';

class QuizCounterController extends GetxController {
  static const int _startValue = 3;

  RxInt countdownRx = _startValue.obs;
}
