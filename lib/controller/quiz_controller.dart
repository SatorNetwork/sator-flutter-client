import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';
import 'package:satorio/controller/quiz_lobby_controller.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/data/model/payload/payload_challenge_result_model.dart';
import 'package:satorio/data/model/payload/payload_countdown_model.dart';
import 'package:satorio/data/model/payload/payload_question_model.dart';
import 'package:satorio/data/model/payload/payload_question_result_model.dart';
import 'package:satorio/data/model/payload/payload_user_model.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/success_answer_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class QuizController extends GetxController {
  Challenge challenge;
  GetSocket _socket;

  final Rx<QuizScreenType> screenTypeRx = Rx(QuizScreenType.countdown);

  final SatorioRepository _satorioRepository = Get.find();

  @override
  void onClose() {
    if (_socket != null) {
      _socket.close();
      _socket.dispose();
      _socket = null;
    }
    super.onClose();
  }

  void back() {
    Get.back();
  }

  void setChallenge(Challenge challenge) {
    this.challenge = challenge;

    _initSocket(challenge.id);
  }

  void _initSocket(String challengeId) async {
    _socket = await _satorioRepository.createSocket(challengeId);

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
      print('onMessage $data');
      print('------');
      if (data is String) {
        Map jsonData = json.decode(data);
        String type = jsonData['type'];
        var payload = jsonData['payload'];

        if (type != null && payload != null)
          switch (type) {
            case 'player_connected':
              _handlePayloadUser(
                  PayloadUserModel.fromJson(payload), true);
              break;
            case 'player_disconnected':
              _handlePayloadUser(
                  PayloadUserModel.fromJson(payload), false);
              break;
            case 'countdown':
              _handlePayloadCountdown(
                  PayloadCountdownModel.fromJson(payload));
              break;
            case 'question':
              _handlePayloadQuestion(
                  PayloadQuestionModel.fromJson(payload));
              break;
            case 'question_result':
              _handlePayloadQuestionResult(
                  PayloadQuestionResultModel.fromJson(payload));
              break;
            case 'challenge_result':
              _handlePayloadChallengeResult(
                  PayloadChallengeResultModel.fromJson(payload));
              break;
          }
      }
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
    if (screenTypeRx.value == QuizScreenType.lobby) {
      screenTypeRx.value = QuizScreenType.countdown;
    }

    QuizCounterController quizCounterController = Get.find();
    quizCounterController.countdownRx.value = payloadCountdown.countdown;
  }

  void _handlePayloadQuestion(PayloadQuestion payloadQuestion) {
    if (Get.isDialogOpen || Get.isBottomSheetOpen) {
      Get.back();
    }
    if (screenTypeRx.value == QuizScreenType.countdown) {
      screenTypeRx.value = QuizScreenType.question;
    }

    QuizQuestionController quizQuestionController = Get.find();
    quizQuestionController.updatePayloadQuestion(payloadQuestion);
  }

  void _handlePayloadQuestionResult(
      PayloadQuestionResult payloadQuestionResult) {
    if (payloadQuestionResult.result) {
      //correct answer
      Get.bottomSheet(SuccessAnswerBottomSheet(payloadQuestionResult));
    } else {
      // wrong answer
      Get.dialog(DefaultDialog(
        'txt_oops'.tr,
        'txt_wrong_answer'.tr,
        'txt_back_home'.tr,
        icon: Icons.close_rounded,
        onPressed: () {
          Get.back(closeOverlays: true);
        },
      ));
    }
  }

  void _handlePayloadChallengeResult(
    PayloadChallengeResult payloadChallengeResult,
  ) {
    if (Get.isDialogOpen || Get.isBottomSheetOpen) {
      Get.back();
    }
    if (screenTypeRx.value == QuizScreenType.question) {
      screenTypeRx.value = QuizScreenType.result;
    }

    QuizResultController quizResultController = Get.find();
    quizResultController.resultRx.value = payloadChallengeResult;
  }

  void sendAnswer(String questionId, String answerId) {
    _satorioRepository.sendAnswer(_socket, questionId, answerId);
  }
}
