import 'package:dart_nats/dart_nats.dart';

abstract class NatsDataSource {
  Future<Subscription> subscribe(String url, String subject);

  Future<void> unsubscribe(Subscription subscription);

  Future<void> sendAnswer(
    String answerSubject,
    String questionId,
    String answerId,
  );
}
