import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/request/nft_filter_request.dart';
import 'package:satorio/data/request/pagination_request.dart';

class FilteredNftsRequest implements ToJsonInterface {
  const FilteredNftsRequest(this.orderBy, this.order, this.onSale, this.page,
      this.numOfItems, this.owner, this.showIds);

  final String? orderBy;
  final String? order;
  final String? onSale;
  final int? page;
  final int? numOfItems;
  final String? owner;
  final List<String>? showIds;

  @override
  Map toJson() => {
        'order_by': orderBy,
        'order': order,
        'on_sale': onSale,
        'pagination': PaginationRequest(page, numOfItems),
        'owner': owner,
        'filter': NftFilterRequest(showIds)
      };
}
