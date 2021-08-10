import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';
import 'package:satorio/controller/quiz_lobby_controller.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/data/model/payload/socket_message_factory.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';
import 'package:satorio/domain/entities/payload/socket_message.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/success_answer_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class QuizController extends GetxController with BackToMainMixin {
  late final Rx<Challenge> challengeRx;
  GetSocket? _socket;

  final Rx<QuizScreenType> screenTypeRx = Rx(QuizScreenType.lobby);

  final SatorioRepository _satorioRepository = Get.find();

  QuizController() {
    QuizArgument argument = Get.arguments as QuizArgument;
    challengeRx = Rx(argument.challenge);
    _initSocket(argument.challenge.id);
  }

  @override
  void onClose() {
    if (_socket != null) {
      _socket!.close();
      _socket = null;
    }
    super.onClose();
  }

  void back() {
    Get.back();
  }

  Future<void> sendAnswer(String questionId, String answerId) {
    return _satorioRepository.sendAnswer(_socket, questionId, answerId);
  }

  void _initSocket(String challengeId) async {
    _socket = await _satorioRepository.createQuizSocket(challengeId);

    _socket?.onOpen(() {
      print('Socket onOpen ${_socket?.url}');
    });
    _socket?.onClose((close) {
      print('Socket onClose $close');
    });
    _socket?.onError((e) {
      print('Socket onError $e');
    });
    _socket?.onMessage((data) {
      print('onMessage $data');
      if (data is String) {
        SocketMessage socketMessage =
            SocketMessageModelFactory.createSocketMessage(json.decode(data));
        switch (socketMessage.type) {
          case Type.player_connected:
            _handlePayloadUser(socketMessage.payload as PayloadUser, true);
            break;
          case Type.player_disconnected:
            _handlePayloadUser(socketMessage.payload as PayloadUser, false);
            break;
          case Type.countdown:
            _handlePayloadCountdown(socketMessage.payload as PayloadCountdown);
            break;
          case Type.question:
            _handlePayloadQuestion(socketMessage.payload as PayloadQuestion);
            break;
          case Type.question_result:
            _handlePayloadQuestionResult(
                socketMessage.payload as PayloadQuestionResult);
            break;
          case Type.challenge_result:
            _handlePayloadChallengeResult(
                socketMessage.payload as PayloadChallengeResult);
            break;
        }
      }
    });
    _socket?.connect();
  }

  void _handlePayloadUser(PayloadUser payloadUser, bool isAdd) {
    QuizLobbyController lobbyController = Get.find();
    lobbyController.usersRx.update((value) {
      if (value != null) {
        if (isAdd)
          value.add(payloadUser);
        else
          value.removeWhere((element) => element.userId == payloadUser.userId);
      }
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
    bool isDialogOpen = Get.isDialogOpen ?? false;
    bool isBottomSheetOpen = Get.isBottomSheetOpen ?? false;
    if (isDialogOpen || isBottomSheetOpen) {
      Get.back();
    }
    bool restart = true;
    if (screenTypeRx.value == QuizScreenType.countdown) {
      screenTypeRx.value = QuizScreenType.question;
      restart = false;
    }

    QuizQuestionController quizQuestionController = Get.find();
    quizQuestionController.updatePayloadQuestion(payloadQuestion, restart);
  }

  void _handlePayloadQuestionResult(
      PayloadQuestionResult payloadQuestionResult) {
    if (payloadQuestionResult.result) {
      //correct answer
      Get.bottomSheet(
        SuccessAnswerBottomSheet(payloadQuestionResult),
      );
    } else {
      // wrong answer
      Get.dialog(
        DefaultDialog(
          'txt_oops'.tr,
          'txt_wrong_answer'.tr,
          'txt_back_home'.tr,
          icon: Icons.sentiment_dissatisfied_rounded,
          onPressed: () {
            backToMain();
          },
        ),
        barrierDismissible: false,
      );
    }
  }

  void _handlePayloadChallengeResult(
    PayloadChallengeResult payloadChallengeResult,
  ) {
    bool isDialogOpen = Get.isDialogOpen ?? false;
    bool isBottomSheetOpen = Get.isBottomSheetOpen ?? false;
    if (isDialogOpen || isBottomSheetOpen) {
      Get.back();
    }
    if (screenTypeRx.value == QuizScreenType.question) {
      screenTypeRx.value = QuizScreenType.result;
    }

    QuizResultController quizResultController = Get.find();
    quizResultController.resultRx.value = payloadChallengeResult;
  }
}

class QuizArgument {
  final Challenge challenge;

  const QuizArgument(this.challenge);
}
