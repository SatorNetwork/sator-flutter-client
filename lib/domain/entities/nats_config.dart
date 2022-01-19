class NatsConfig {
  final String baseQuizUrl;
  final String baseQuizWsUrl;
  final String receiveSubj;
  final String sendSubj;
  final String userId;
  final String serverPublicKey;

  const NatsConfig(
    this.baseQuizUrl,
    this.baseQuizWsUrl,
    this.receiveSubj,
    this.sendSubj,
    this.userId,
    this.serverPublicKey,
  );
}
