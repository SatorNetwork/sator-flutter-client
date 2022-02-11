import 'package:satorio/data/model/to_json_interface.dart';

class NftFilterRequest implements ToJsonInterface {
  const NftFilterRequest(this.tagIds);

  final List<String>? tagIds;

  @override
  Map toJson() => {
        'tag_ids': tagIds,
      };
}
