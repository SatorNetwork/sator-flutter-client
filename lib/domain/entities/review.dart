class Review {
  final String id;
  final String userId;
  final String userName;
  final int rating;
  final String title;
  final String text;
  final DateTime? createdAt;
  final int likes;
  final int unlikes;

  const Review(this.id, this.userId, this.userName, this.rating, this.title,
      this.text, this.createdAt, this.likes, this.unlikes);
}
