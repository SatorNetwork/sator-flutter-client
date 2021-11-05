import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/util/extension.dart';

class NftCategoryModel extends NftCategory implements ToJsonInterface {
  const NftCategoryModel(String id, String title) : super(id, title);

  factory NftCategoryModel.fromJson(Map json) => NftCategoryModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
      };
}
