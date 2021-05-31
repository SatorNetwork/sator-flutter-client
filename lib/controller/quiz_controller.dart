import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';
import 'package:satorio/controller/quiz_lobby_controller.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class QuizController extends GetxController {
  Challenge challenge;
  GetSocket _socket;

  final Rx<QuizScreenType> screenTypeRx = Rx(QuizScreenType.lobby);

  final SatorioRepository _satorioRepository = Get.find();

  @override
  void onClose() {
    if (_socket != null) {
      _socket.dispose();
      _socket.close();
      _socket = null;
    }
  }

  void back() {
    Get.back();
  }

  void setChallenge(Challenge challenge) {
    this.challenge = challenge;

    _initSocket(challenge.play);
  }

  void _initSocket(String url) async {
    _socket = await _satorioRepository.createSocket(url);

    _socket.onOpen(() {
      print('Socket onOpen ${_socket.url}');
    });
    _socket.onClose((close) {
      print('Socket onClose ${close.message}');
    });
    _socket.onError((e) {
      print('Socket onError ${e.message}');
    });
    _socket.onMessage((data) {
      print('Socket onMessage: $data');
    });
    _socket.connect();
  }

  void _handlePayloadUser(PayloadUser payloadUser, bool isAdd) {
    QuizLobbyController lobbyController = Get.find();
    lobbyController.usersRx.update((value) {
      if (isAdd)
        value.add(payloadUser);
      else
        value.removeWhere((element) => element.userId == payloadUser.userId);
    });
  }

  void _handlePayloadCountdown(PayloadCountdown payloadCountdown) {
    QuizCounterController quizCounterController = Get.find();
    quizCounterController.countdownRx.value = payloadCountdown.countdown;

    if (screenTypeRx.value == QuizScreenType.lobby) {
      screenTypeRx.value = QuizScreenType.countdown;
    }
  }

  void _handlePayloadQuestion(PayloadQuestion payloadQuestion) {
    QuizQuestionController quizQuestionController = Get.find();
    quizQuestionController.updatePayloadQuestion(payloadQuestion);

    if (Get.isDialogOpen || Get.isBottomSheetOpen) {
      Get.back();
    }
    if (screenTypeRx.value == QuizScreenType.countdown) {
      screenTypeRx.value = QuizScreenType.question;
    }
  }

  void _handlePayloadQuestionResult(
      PayloadQuestionResult payloadQuestionResult) {
    if (payloadQuestionResult.result) {
      //correct answer
      // Get.bottomSheet();
    } else {
      // wrong answer
      Get.dialog(DefaultDialog(
        'txt_oops'.tr,
        'txt_wrong_answer'.tr,
        'txt_back_home'.tr,
        icon: Icons.close_rounded,
        onPressed: () {},
      ));
    }
  }

  void _handlePayloadChallengeResult(
      PayloadChallengeResult payloadChallengeResult) {
    QuizResultController quizResultController = Get.find();
    quizResultController.resultRx.value = payloadChallengeResult;

    if (Get.isDialogOpen || Get.isBottomSheetOpen) {
      Get.back();
    }
    if (screenTypeRx.value == QuizScreenType.question) {
      screenTypeRx.value = QuizScreenType.result;
    }
  }

  void sendAnswer(String questionId, String answerId) {
    _satorioRepository.sendAnswer(_socket, questionId, answerId);
  }
}
