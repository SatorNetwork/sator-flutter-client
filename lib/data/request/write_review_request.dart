import 'package:satorio/data/model/to_json_interface.dart';

class WriteReviewRequest implements ToJsonInterface {
  final int rating;
  final String title;
  final String review;

  const WriteReviewRequest(this.rating, this.title, this.review);

  @override
  Map toJson() => {
        'rating': rating,
        'title': title,
        'review': review,
      };
}
