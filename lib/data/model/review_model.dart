import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/util/extension.dart';

class ReviewModel extends Review implements ToJsonInterface {
  const ReviewModel(
    String id,
    String userId,
    String userName,
    String userAvatar,
    int rating,
    String title,
    String review,
    DateTime? createdAt,
    int likes,
    int dislikes,
    bool isLiked,
    bool isDisliked,
  ) : super(
          id,
          userId,
          userName,
          userAvatar,
          rating,
          title,
          review,
          createdAt,
          likes,
          dislikes,
          isLiked,
          isDisliked,
        );

  factory ReviewModel.fromJson(Map json) => ReviewModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('user_id'),
        json.parseValueAsString('username'),
        json.parseValueAsString('user_avatar'),
        json.parseValueAsInt('rating'),
        json.parseValueAsString('title'),
        json.parseValueAsString('review'),
        json.tryParseValueAsDateTime('created_at'),
        json.parseValueAsInt('likes'),
        json.parseValueAsInt('dislikes'),
        json.parseValueAsBool('is_liked'),
        json.parseValueAsBool('is_disliked'),
      );

  @override
  Map toJson() => {
        'id': id,
        'user_id': userId,
        'username': userName,
        'user_avatar': userAvatar,
        'rating': rating,
        'title': title,
        'review': review,
        'created_at': createdAt!.toIso8601String(),
        'likes': likes,
        'dislikes': dislikes,
        'is_liked': isLiked,
        'is_disliked': isDisliked,
      };
}
