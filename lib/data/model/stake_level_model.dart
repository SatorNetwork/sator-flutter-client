import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/stake_level.dart';
import 'package:satorio/util/extension.dart';

class StakeLevelModel extends StakeLevel implements ToJsonInterface {
  const StakeLevelModel(
    String id,
    double minAmount,
    double minDaysToStake,
    String title,
    String subTitle,
    String rewards,
    bool isCurrent,
  ) : super(
          id,
          minAmount,
          minDaysToStake,
          title,
          subTitle,
          rewards,
          isCurrent,
        );

  factory StakeLevelModel.fromJson(Map json) => StakeLevelModel(
        json.parseValueAsString('id'),
        json.parseValueAsDouble('min_amount'),
        json.parseValueAsDouble('min_days_to_stake'),
        json.parseValueAsString('title'),
        json.parseValueAsString('sub_title'),
        json.parseValueAsString('rewards'),
        json.parseValueAsBool('is_current'),
      );

  @override
  Map toJson() => {
        'id': id,
        'min_amount': minAmount,
        'min_days_to_stake': minDaysToStake,
        'title': title,
        'sub_title': subTitle,
        'rewards': rewards,
        'is_current': isCurrent,
      };
}
