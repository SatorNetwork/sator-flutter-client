import 'package:satorio/data/model/to_json_interface.dart';

class RateRequest implements ToJsonInterface {
  const RateRequest(this.rating);

  final int rating;

  @override
  Map toJson() => {
        'rating': rating,
      };
}
