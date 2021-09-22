import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/data/model/last_seen_model.dart';
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
  late final DatabaseReference _timestampsRef;
  late Rx<bool> isMessagesRx = Rx(false);
  late Profile profile;

  static const String DATABASE_URL = 'https://sator-f44d6-timestamp.firebaseio.com/';

  bool canSendMessage() => messageController.text.length > 0;

  void _saveMessage(MessageModel message) {
    _messagesRef.push().set(message.toJson());
    //TODO: refactor
    _messagesRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        isMessagesRx.value = true;
      }
    });
  }

  ChatController() {
    ChatArgument argument = Get.arguments;
    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);
    _messagesRef = argument.messagesRef;

    this.profileListenable =
    _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    profile = profileListenable.value.getAt(0)!;

    _timestampsRef = FirebaseDatabase(databaseURL: DATABASE_URL)
        .reference()
        .child(profile.id).child(argument.showEpisode.id);

    //TODO: refactor
    _messagesRef.once().then((DataSnapshot snapshot) {
      isMessagesRx.value = snapshot.value != null;
    });
  }

  Query getMessageQuery() {
    return _messagesRef;
  }

  void saveTimestamp() {
    print('saveTimestamp');
    _timestampsRef.push().set(LastSeenModel(DateTime.now()).toJson());
  }

  void back() {
    //TODO: refactor
    ShowEpisodeRealmController showEpisodeRealmController = Get.find();
    _messagesRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        showEpisodeRealmController.isMessagesRx.value = true;
      }
      Get.back();
    });
  }

  void sendMessage() {
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
