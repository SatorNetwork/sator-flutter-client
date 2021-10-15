import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/auction_params.dart';
import 'package:satorio/util/extension.dart';

class AuctionParamsModel extends AuctionParams implements ToJsonInterface {
  const AuctionParamsModel(
    double startingBid,
    DateTime? startAt,
    DateTime? endAt,
  ) : super(
          startingBid,
          startAt,
          endAt,
        );

  factory AuctionParamsModel.fromJson(Map json) => AuctionParamsModel(
      json.parseValueAsDouble('starting_bid'),
      json.tryParseValueAsDateTime('start_timestamp'),
      json.tryParseValueAsDateTime('end_timestamp'));

  @override
  Map toJson() => {
        'starting_bid': startingBid,
        'start_timestamp': startAt?.toIso8601String() ?? '',
        'end_timestamp': endAt?.toIso8601String() ?? '',
      };
}
