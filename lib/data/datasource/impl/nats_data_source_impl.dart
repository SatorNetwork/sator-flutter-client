import 'dart:async';
import 'dart:convert';

import 'package:dart_nats/dart_nats.dart';
import 'package:flutter/foundation.dart';
import 'package:satorio/data/datasource/nats_data_source.dart';
import 'package:satorio/data/encrypt/ecrypt_manager.dart';
import 'package:satorio/data/model/payload/payload_answer_model.dart';
import 'package:satorio/data/model/payload/payload_empty_model.dart';
import 'package:satorio/data/model/payload/socket_message_factory.dart';
import 'package:satorio/data/model/to_json_interface.dart';

class NatsDataSourceImpl implements NatsDataSource {
  final Client _client = Client();
  final EncryptManager _encryptManager;

  NatsDataSourceImpl(this._encryptManager) {
    if (kDebugMode) {
      _client.statusStream.listen((Status status) {
        print('NATS status - $status');
      });
    }
  }

  Future<void> _sendViaClient(
    String subject,
    String serverPublicKey,
    ToJsonInterface data,
  ) async {
    final String jsonData = json.encode(data.toJson());

    final encrypted = await _encryptManager.encrypt(serverPublicKey, jsonData);

    if (_client.status == Status.connected) {
      bool result = _client.pubString(subject, encrypted);
      print(
          'onSend ${DateTime.now().toIso8601String()} ${result ? 'success' : 'error'} $subject: $jsonData');
    }
  }

  @override
  Future<Subscription> subscribe(String url, String subject) {
    return _client
        .connect(
          Uri.parse(url),
        )
        .then(
          (value) => _client.sub(subject),
        );
  }

  @override
  Future<void> unsubscribe(Subscription subscription) {
    _client.unSub(subscription);
    return _client.close();
  }

  @override
  Future<void> sendAnswer(
    String answerSubject,
    String serverPublicKey,
    String questionId,
    String answerId,
  ) {
    SocketMessageAnswerModel message = SocketMessageAnswerModel(
      PayloadAnswerModel(questionId, answerId),
      DateTime.now(),
      60000,
    );

    return _sendViaClient(answerSubject, serverPublicKey, message);
  }

  @override
  Future<void> sendPing(
    String subject,
    String serverPublicKey,
  ) {
    SocketMessagePlayerIsActiveModel message = SocketMessagePlayerIsActiveModel(
      PayloadEmptyModel(),
      DateTime.now(),
      1000,
    );
    return _sendViaClient(subject, serverPublicKey, message);
  }

  @override
  Future<String> decryptReceivedMessage(String data) {
    return _encryptManager.decrypt(data).then(
      (value) {
        print('onMessage ${DateTime.now().toIso8601String()} $value');
        return value;
      },
    );
  }
}
