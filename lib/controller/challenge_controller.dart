import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/quiz_binding.dart';
import 'package:satorio/binding/show_episode_quiz_binding.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/nats_config.dart';
import 'package:satorio/domain/entities/paid_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/episode_realm_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_paid_activation_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_unlock_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/quiz_page.dart';
import 'package:satorio/ui/page_widget/show_episode_quiz_page.dart';
import 'package:share_plus/share_plus.dart';

class ChallengeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Challenge?> challengeRx = Rx(null);
  final RxBool isRequested = false.obs;

  ChallengeController() {
    ChallengeArgument argument = Get.arguments as ChallengeArgument;
    _reloadChallenge(argument.challengeId);
  }

  void back() {
    Get.back();
  }

  void playChallenge() {
    if (challengeRx.value == null) return;

    Future.value(true)
        .then((value) {
          isRequested.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.quizNats(challengeRx.value!.id),
        )
        .then(
          (natsConfig) {
            isRequested.value = false;
            _toQuiz(natsConfig);
          },
        )
        .catchError((value) {
          isRequested.value = false;
        });
  }

  void shareChallenge() {
    if (challengeRx.value != null) {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://satorio.page.link',
        link: Uri.parse(
            'https://satorio.page.link/quiz-invite?id=${challengeRx.value!.id}'),
        androidParameters: AndroidParameters(
          packageName: 'com.satorio.app',
          minimumVersion: 0,
        ),
        // iosParameters: IosParameters(
        //   bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        //   minimumVersion: '0',
        // ),
      );

      parameters.buildShortLink().then((value) {
        print(value.shortUrl);
        Share.share(value.shortUrl.toString());
      });
    }
  }

  void toEpisodeRealmDialog() {
    if (challengeRx.value != null) {
      Get.bottomSheet(
        EpisodeRealmBottomSheet(
          onQuizPressed: () {
            if (challengeRx.value!.attemptsLeft > 0) {
              _loadQuizQuestion();
            } else {
              Get.dialog(
                DefaultDialog(
                  'txt_oops'.tr,
                  'txt_attempts_left_alert'.tr,
                  'txt_ok'.tr,
                ),
              );
            }
          },
          onPaidUnlockPressed: () {
            _toRealmPaidActivationBottomSheet();
          },
        ),
        isScrollControlled: true,
        enableDrag: false,
        barrierColor: Colors.transparent,
      );
    }
  }

  void _reloadChallenge(String challengeId) {
    _satorioRepository.challenge(challengeId).then((Challenge challenge) {
      challengeRx.value = challenge;
    });
  }

  void _toQuiz(NatsConfig natsConfig) async {
    Get.off(
      () => QuizPage(),
      binding: QuizBinding(),
      arguments: QuizArgument(
        challengeRx.value!,
        natsConfig,
      ),
    );

    // final result = await Get.to(
    //   () => QuizPage(),
    //   binding: QuizBinding(),
    //   arguments: QuizArgument(
    //     challengeRx.value!,
    //     natsConfig,
    //   ),
    // );
    // if (challengeRx.value != null) {
    //   _reloadChallenge(challengeRx.value!.id);
    // }
  }

  void _loadQuizQuestion() {
    if (challengeRx.value != null) {
      Future.value(true)
          .then((value) {
            isRequested.value = true;
            return value;
          })
          .then(
            (value) => _satorioRepository
                .showEpisodeQuizQuestion(challengeRx.value!.episodeId),
          )
          .then((PayloadQuestion payloadQuestion) {
            isRequested.value = false;
            _toEpisodeQuiz(payloadQuestion);
          })
          .catchError(
            (value) {
              isRequested.value = false;
            },
          );
    }
  }

  void _toEpisodeQuiz(PayloadQuestion payloadQuestion) async {
    final result = await Get.to(
      () => ShowEpisodeQuizPage(),
      binding: ShowEpisodeQuizBinding(),
      arguments: ShowEpisodeQuizArgument(
        null,
        null,
        payloadQuestion,
      ),
    );

    if (result != null && result is bool && result) {
      _toUnlockBottomSheet();
    }

    if (challengeRx.value != null) {
      _reloadChallenge(challengeRx.value!.id);
    }
  }

  void _toRealmPaidActivationBottomSheet() {
    Get.bottomSheet(
      RealmPaidActivationBottomSheet(
        (paidOption) {
          _paidUnlock(paidOption);
        },
      ),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
    );
  }

  void _paidUnlock(PaidOption paidOption) {
    if (challengeRx.value != null) {
      Future.value(true)
          .then((value) {
            isRequested.value = true;
            return value;
          })
          .then(
            (value) => _satorioRepository.paidUnlockEpisode(
              challengeRx.value!.episodeId,
              paidOption.label,
            ),
          )
          .then(
            (EpisodeActivation episodeActivation) {
              isRequested.value = false;
              if (episodeActivation.isActive) {
                _toUnlockBottomSheet();
                _reloadChallenge(challengeRx.value!.id);
              }
            },
          )
          .catchError(
            (value) {
              isRequested.value = false;
            },
          );
    }
  }

  void _toUnlockBottomSheet() {
    Get.bottomSheet(
      RealmUnlockBottomSheet(),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      enableDrag: false,
    );
  }
}

class ChallengeArgument {
  final String challengeId;

  const ChallengeArgument(this.challengeId);
}
