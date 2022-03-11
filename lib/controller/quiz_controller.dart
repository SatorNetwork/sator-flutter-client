import 'dart:async';
import 'dart:convert';

import 'package:dart_nats/dart_nats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/challenges_binding.dart';
import 'package:satorio/controller/challenges_controller.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';
import 'package:satorio/controller/quiz_lobby_controller.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/data/model/payload/socket_message_factory.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/nats_config.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_countdown.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/domain/entities/payload/payload_time_out.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';
import 'package:satorio/domain/entities/payload/socket_message.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/success_answer_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/challenges_page.dart';

class QuizController extends GetxController {
  late final Rx<Challenge> challengeRx;
  late final NatsConfig natsConfig;

  late final Subscription _subscription;
  late final StreamSubscription<Message>? _streamSubscription;
  late final Timer _pingTimer;

  final Rx<QuizScreenType> screenTypeRx = Rx(QuizScreenType.lobby);

  final SatorioRepository _satorioRepository = Get.find();

  QuizController() {
    QuizArgument argument = Get.arguments as QuizArgument;
    challengeRx = Rx(argument.challenge);
    natsConfig = argument.natsConfig;

    _initConnection();
  }

  @override
  void onClose() {
    _pingTimer.cancel();
    _streamSubscription?.cancel();
    _satorioRepository.unsubscribeNats(_subscription);

    super.onClose();
  }

  void backToEpisode() {
    _satorioRepository.updateWalletBalance();
    Get.until((route) => !Get.isOverlaysOpen);
    if (Get.isRegistered<ShowEpisodeRealmController>()) {
      Get.until((route) {
        return Get.currentRoute == '/() => ShowEpisodesRealmPage';
      });
    } else {
      Get.back();
    }
  }

  void back() {
    Get.back();
  }

  void toChallenges() {
    if (Get.isRegistered<ChallengesController>()) {
      Get.until((route) => Get.currentRoute == '/() => ChallengesPage');
    } else {
      Get.off(
        () => ChallengesPage(),
        binding: ChallengesBinding(),
      );
    }
  }

  Future<void> sendAnswer(String questionId, String answerId) {
    return _satorioRepository.sendAnswer(
      natsConfig.sendSubj,
      natsConfig.serverPublicKey,
      questionId,
      answerId,
    );
  }

  void _initConnection() async {
    _subscription = await _satorioRepository.subscribeNats(
        natsConfig.baseQuizWsUrl, natsConfig.receiveSubj);

    _streamSubscription = _subscription.stream?.listen((Message message) {
      String data = message.string;
      _handleReceivedMessage(data);
    });

    _pingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _satorioRepository.sendPing(
          natsConfig.sendSubj, natsConfig.serverPublicKey);
    });
  }

  void _handleReceivedMessage(String message) {
    _satorioRepository.decryptData(message).then((String value) {
      SocketMessage socketMessage =
          SocketMessageModelFactory.createSocketMessage(json.decode(value));

      if (_isMessageExpired(socketMessage)) {
        print('Message EXPIRED !!!');
        return;
      }

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
        case Type.time_out:
          _handleTimeOut(socketMessage.payload as PayloadTimeOut);
          break;
      }
    });
  }

  bool _isMessageExpired(SocketMessage message) {
    if (message.date == null) {
      return true;
    } else {
      return DateTime.now().difference(message.date!).inMilliseconds >
          message.ttl;
    }
  }

  void _handlePayloadUser(PayloadUser payloadUser, bool isAdd) {
    QuizLobbyController lobbyController = Get.find();
    lobbyController.usersRx.update((value) {
      if (value != null) {
        if (isAdd) {
          if (value.indexWhere(
                  (element) => element.userId == payloadUser.userId) ==
              -1) value.add(payloadUser);
        } else {
          value.removeWhere((element) => element.userId == payloadUser.userId);
        }
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
      Get.until((route) => !Get.isOverlaysOpen);
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
          'txt_keep_going'.tr,
          icon: Icons.sentiment_dissatisfied_rounded,
          onButtonPressed: () {
            Get.until((route) => !Get.isOverlaysOpen);
          },
        ),
        barrierDismissible: true,
      );
    }
  }

  void _handlePayloadChallengeResult(
    PayloadChallengeResult payloadChallengeResult,
  ) {
    bool isDialogOpen = Get.isDialogOpen ?? false;
    bool isBottomSheetOpen = Get.isBottomSheetOpen ?? false;
    if (isDialogOpen || isBottomSheetOpen) {
      Get.until((route) => !Get.isOverlaysOpen);
    }
    if (screenTypeRx.value == QuizScreenType.question) {
      screenTypeRx.value = QuizScreenType.result;
    }

    QuizResultController quizResultController = Get.find();
    quizResultController.updateQuizResult(payloadChallengeResult);
  }

  _handleTimeOut(PayloadTimeOut payloadTimeOut) {
    Get.dialog(
      DefaultDialog(
        'txt_oops'.tr,
        payloadTimeOut.message,
        'txt_back_realm'.tr,
        icon: Icons.sentiment_dissatisfied_rounded,
        onButtonPressed: () {
          backToEpisode();
        },
      ),
      barrierDismissible: false,
    );
  }
}

class QuizArgument {
  final Challenge challenge;
  final NatsConfig natsConfig;

  const QuizArgument(this.challenge, this.natsConfig);
}
