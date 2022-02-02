import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_category.dart';
import 'package:satorio/util/extension.dart';

class ShowCategoryModel extends ShowCategory implements ToJsonInterface {
  const ShowCategoryModel(
    String id,
    String title,
    bool disabled,
    int sort,
    List<ShowModel> shows,
  ) : super(id, title, disabled, sort, shows);

  factory ShowCategoryModel.fromJson(Map json) => ShowCategoryModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsBool('disabled'),
        json.parseValueAsInt('sort'),
        (json['shows'] == null || !(json['shows'] is Iterable))
            ? []
            : (json['shows'] as Iterable)
                .where((element) => element != null)
                .map((element) => ShowModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'disabled': disabled,
        'sort': sort,
      };
}
