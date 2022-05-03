import 'package:satorio/data/model/to_json_interface.dart';

class NftFilterRequest implements ToJsonInterface {
  const NftFilterRequest(this.tagIds, this.onSale, this.owner);

  final List<String>? tagIds;
  final String? onSale;
  final String? owner;

  @override
  Map toJson() => {
        'tag_ids': tagIds,
        'on_sale': onSale,
        'owner': owner,
      };
}
