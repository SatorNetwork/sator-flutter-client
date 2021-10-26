import 'package:satorio/data/model/nft_item_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/util/extension.dart';

class NftHomeModel extends NftHome implements ToJsonInterface {
  const NftHomeModel(
    String id,
    String title,
    List<NftItemModel> items,
  ) : super(
          id,
          title,
          items,
        );

  factory NftHomeModel.fromJson(Map json) => NftHomeModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        (json['items'] == null || !(json['items'] is Iterable))
            ? []
            : (json['items'] as Iterable)
                .where((element) => element != null)
                .map((element) => NftItemModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'items': items
            .where((element) => element is ToJsonInterface)
            .map((element) => (element as ToJsonInterface).toJson())
            .toList(),
      };
}
