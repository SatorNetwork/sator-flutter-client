import 'package:satorio/data/model/to_json_interface.dart';

class PaginationRequest implements ToJsonInterface {
  const PaginationRequest(this.page, this.numOfItems);

  final int? page;
  final int? numOfItems;

  @override
  Map toJson() => {'page': page, 'num_of_items': numOfItems};
}
