import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/request/pagination_request.dart';

class FilteredNftsRequest implements ToJsonInterface {
  const FilteredNftsRequest(this.orderBy, this.order, this.onSale, this.page,
      this.numOfItems, this.owner);

  final String? orderBy;
  final String? order;
  final bool? onSale;
  final int? page;
  final int? numOfItems;
  final String? owner;

  @override
  Map toJson() => {
        'order_by': orderBy,
        'order': order,
        'on_sale': onSale,
        'pagination': PaginationRequest(page, numOfItems),
        'owner': owner,
      };
}
