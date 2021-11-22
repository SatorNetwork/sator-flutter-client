import 'dart:async';
import 'dart:convert';

import 'package:dart_nats/dart_nats.dart';
import 'package:flutter/foundation.dart';
import 'package:satorio/data/datasource/nats_data_source.dart';
import 'package:satorio/data/model/payload/payload_answer_model.dart';
import 'package:satorio/data/model/payload/socket_message_factory.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/environment.dart';

class NatsDataSourceImpl implements NatsDataSource {
  final Client _client = Client();

  NatsDataSourceImpl() {
    if (kDebugMode) {
      _client.statusStream.listen((Status status) {
        print('NATS status - $status');
      });
    }
  }

  Future<void> _sendViaClient(
    String subject,
    ToJsonInterface data,
  ) async {
    String jsonData = json.encode(data.toJson());
    bool result = _client.pubString(subject, jsonData);
    print('nSend ${result ? 'success' : 'error'} $subject: $jsonData');
  }

  @override
  Future<Subscription> subscribe(String subject) {
    return _client.connect(Uri.parse(Environment.baseUrl)).then(
      (value) {
        return _client.sub(subject);
      },
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
    String questionId,
    String answerId,
  ) {
    SocketMessageAnswerModel message = SocketMessageAnswerModel(
      PayloadAnswerModel(questionId, answerId),
    );

    return _sendViaClient(answerSubject, message);
  }
}
