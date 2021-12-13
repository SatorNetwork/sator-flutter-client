class NatsConfig {
  final String baseQuizUrl;
  final String receiveSubj;
  final String sendSubj;
  final String userId;

  const NatsConfig(
      this.baseQuizUrl,
      this.receiveSubj,
      this.sendSubj,
      this.userId,
      );
}