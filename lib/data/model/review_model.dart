import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/util/extension.dart';

class ReviewModel extends Review implements ToJsonInterface {
  const ReviewModel(
    String id,
    String userId,
    String userName,
    int rating,
    String title,
    String review,
    DateTime? createdAt,
    int likes,
    int unlikes,
  ) : super(
          id,
          userId,
          userName,
          rating,
          title,
          review,
          createdAt,
          likes,
          unlikes,
        );

  factory ReviewModel.fromJson(Map json) => ReviewModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('user_id'),
        json.parseValueAsString('username'),
        json.parseValueAsInt('rating'),
        json.parseValueAsString('title'),
        json.parseValueAsString('review'),
        json.tryParseValueAsDateTime('createdAt'),
        json.parseValueAsInt('likes'),
        json.parseValueAsInt('unlikes'),
      );

  @override
  Map toJson() => {
        'id': id,
        'user_id': userId,
        'username': userName,
        'rating': rating,
        'title': title,
        'review': review,
        'created_at': createdAt!.toIso8601String(),
        'likes': likes,
        'unlikes': unlikes,
      };
}
