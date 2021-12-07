import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/data/model/last_seen_model.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/entities/last_seen.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/environment.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  AutoScrollController autoScrollController = AutoScrollController();

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;

  late ValueListenable<Box<Profile>> profileListenable;
  late Profile profile;
  late final DatabaseReference _messagesRef;
  late final DatabaseReference _timestampsRef;
  late Rx<bool> isMessagesRx = Rx(false);
  late LastSeen lastSeen;
  DateTime? timestamp;
  late int scrollIndex;

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
  }

  @override
  void onInit() async {
    super.onInit();
    await _satorioRepository.initRemoteConfig();
    final String firebaseUrl = await _satorioRepository.firebaseUrl();

    scrollIndex = 0;

    this.profileListenable =
    _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    profile = profileListenable.value.getAt(0)!;

    _timestampsRef = FirebaseDatabase(databaseURL: firebaseUrl)
        .reference()
        .child(profile.id)
        .child(showEpisodeRx.value.id);

    _scrollToMissedMessages();

    //TODO: refactor
    _messagesRef.once().then((DataSnapshot snapshot) {
      isMessagesRx.value = snapshot.value != null;
    });
  }

  @override
  void onClose() {
    saveTimestamp();
    _checkLastSeen();
    super.onClose();
  }

  Future _scrollToMissedMessages() async {
    //TODO: refactor
    await _timestampsRef.once().then((DataSnapshot snapshot) {
      final json = snapshot.value as Map<dynamic, dynamic>;
      lastSeen = LastSeenModel.fromJson(json);
    });

    await _scroll();
  }

  Query getMessageQuery() {
    return _messagesRef;
  }

  Future _scroll() async {
    List missedMessages = [];
    scrollIndex = 0;
    await _messagesRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value == null) return;

      Map<dynamic, dynamic> values = snapshot.value;

      values.forEach((key, value) {
        if (DateTime.tryParse(value["createdAt"])!.microsecondsSinceEpoch >
            lastSeen.timestamp!.microsecondsSinceEpoch) {
          missedMessages.add(value);
        }
      });
      scrollIndex = missedMessages.length;
      autoScrollController.scrollToIndex(scrollIndex,
          preferPosition: AutoScrollPosition.begin);
    });
  }

  void saveMessageSeen(DateTime time) {
    timestamp = time;
  }

  void saveTimestamp() {
    if (timestamp == null) return;

    _timestampsRef.set(LastSeenModel(timestamp).toJson());
  }

  void back() {
    //TODO: refactor
    ShowEpisodeRealmController showEpisodeRealmController = Get.find();
    _messagesRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        showEpisodeRealmController.isMessagesRx.value = true;
      }

      showEpisodeRealmController.lastSeenInit();
      Get.back();
    });
  }

  void _checkLastSeen() {
    ShowEpisodeRealmController showEpisodeRealmController = Get.find();
    showEpisodeRealmController.lastSeenInit();
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
