import 'package:satorio/data/model/to_json_interface.dart';

class PaidUnlockRequest implements ToJsonInterface {
  const PaidUnlockRequest(this.option);

  final String option;

  @override
  Map toJson() => {
        'option': option,
      };
}
