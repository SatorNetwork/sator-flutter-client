class Message {
  final String text;
  final String fromUserId;
  final String fromUserName;
  final DateTime createdAt;

  const Message(this.text, this.fromUserId, this.fromUserName, this.createdAt);
}