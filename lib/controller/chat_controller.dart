
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/data/model/message_model.dart';
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
  }

  Query getMessageQuery() {
    return _messagesRef;
  }

  void back() {
    Get.back();
  }

  void sendMessage() {
    String id = "jdncfkdjcndks";
    String name = "Jonny";

    if (canSendMessage()) {
      final message = MessageModel(messageController.text, id, name, DateTime.now());
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

  const ChatArgument(this.messagesRef, this.showDetail, this.showSeason, this.showEpisode);
}
