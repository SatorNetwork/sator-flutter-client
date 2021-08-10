import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ChatController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;

  late ValueListenable<Box<Profile>> profileListenable;
  late final DatabaseReference _messagesRef;

  bool canSendMessage() => messageController.text.length > 0;

  void _saveMessage(MessageModel message) {
    _messagesRef.push().set(message.toJson());
  }

  ChatController() {
    ChatArgument argument = Get.arguments;
    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);
    _messagesRef = argument.messagesRef;

    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  Query getMessageQuery() {
    return _messagesRef;
  }

  void back() {
    Get.back();
  }

  void sendMessage() {
    Profile profile = profileListenable.value.getAt(0)!;

    if (canSendMessage()) {
      final message = MessageModel(
          messageController.text, profile.id, profile.username, DateTime.now());
      _saveMessage(message);
      messageController.clear();
    }
  }
}

class ChatArgument {
  final DatabaseReference messagesRef;
  final ShowDetail showDetail;
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;

  const ChatArgument(
      this.messagesRef, this.showDetail, this.showSeason, this.showEpisode);
}
