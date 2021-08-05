
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ChatController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('messages');

  bool canSendMessage() => messageController.text.length > 0;

  void _saveMessage(MessageModel message) {
    _messagesRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _messagesRef;
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
