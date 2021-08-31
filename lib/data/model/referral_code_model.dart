import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/referral_code.dart';

class ReferralCodeModel extends ReferralCode implements ToJsonInterface {
  const ReferralCodeModel(String userId, String referralCode)
      : super(userId, referralCode);

  factory ReferralCodeModel.fromJson(Map json) => ReferralCodeModel(
        json['user_id'] == null ? '' : json['user_id'],
        json['referral_code'] == null ? '' : json['referral_code'],
      );

  @override
  Map toJson() => {
        'user_id': userId,
        'referral_code': referralCode,
      };
}
