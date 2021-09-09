import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/review.dart';

class ReviewModel extends Review implements ToJsonInterface {
  const ReviewModel(String id, String userId, String userName, int rating,
      String title, String text, String createdAt, String likes, String unlikes)
      : super(id, userId, userName, rating, title, text, createdAt, likes,
            unlikes);

  factory ReviewModel.fromJson(Map json) => ReviewModel(
        json['id'] == null ? '' : json['id'],
        json['user_id'] == null ? '' : json['user_id'],
        json['username'] == null ? '' : json['username'],
        json['rating'] == null ? '' : json['rating'],
        json['title'] == null ? '' : json['title'],
        json['review'] == null ? '' : json['review'],
        json['created_at'] == null ? '' : json['created_at'],
        json['likes'] == null ? '' : json['likes'],
        json['unlikes'] == null ? '' : json['unlikes'],
      );

  @override
  Map toJson() => {
        'id': id,
        'user_id': userId,
        'username': userName,
        'rating': rating,
        'title': title,
        'review': text,
        'created_at': createdAt,
        'likes': likes,
        'unlikes': unlikes,
      };
}
