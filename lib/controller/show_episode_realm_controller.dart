import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/binding/chat_binding.dart';
import 'package:satorio/binding/show_episode_quiz_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/controller/chat_controller.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/episode_realm_dialog.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';
import 'package:satorio/ui/page_widget/chat_page.dart';
import 'package:satorio/ui/page_widget/show_episode_quiz_page.dart';

class ShowEpisodeRealmController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;

  late final Rx<ShowEpisode> showEpisodeRx;
  final RxBool isRealmActivatedRx = false.obs;

  ScrollController scrollController = ScrollController();

  late final DatabaseReference _messagesRef;


  Query getMessageQuery() {
    return _messagesRef;
  }

  ShowEpisodeRealmController() {
    ShowEpisodeRealmArgument argument = Get.arguments;
    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);
    _messagesRef = FirebaseDatabase.instance.reference().child(argument.showEpisode.id.toString());

    _satorioRepository
        .isChallengeActivated(argument.showEpisode.id)
        .then((bool result) {
      isRealmActivatedRx.value = result;
    });
  }

  void back() {
    Get.back();
  }

  void toChatPage() {
    Get.to(
          () => ChatPage(),
      binding: ChatBinding(),
      arguments: ChatArgument(_messagesRef, showDetailRx.value, showSeasonRx.value, showEpisodeRx.value),
    );
  }

  void toEpisodeRealmDialog() {
    Get.dialog(
      EpisodeRealmDialog(
        onStartQuizPressed: () {
          Get.back();
          Get.to(
            () => ShowEpisodeQuizPage(),
            binding: ShowEpisodeQuizBinding(),
            arguments: ShowEpisodeQuizArgument(
              showSeasonRx.value,
              showEpisodeRx.value,
            ),
          );
        },
        onScanQrPressed: () {
          Get.back();
          // TODO: open qr scanner
        },
      ),
    );
  }

  toChallenge() {
    Get.to(
      () => ChallengePage(),
      binding: ChallengeBinding(),
      arguments: ChallengeArgument(showEpisodeRx.value.challengeId),
    );
  }
}

class ShowEpisodeRealmArgument {
  final ShowDetail showDetail;
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;

  const ShowEpisodeRealmArgument(
    this.showDetail,
    this.showSeason,
    this.showEpisode,
  );
}
