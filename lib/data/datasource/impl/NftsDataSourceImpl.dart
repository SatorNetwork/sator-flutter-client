import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';
import 'package:satorio/data/datasource/nfts_data_source.dart';
import 'package:satorio/data/model/nft_category_model.dart';
import 'package:satorio/data/model/nft_item_model.dart';
import 'package:satorio/data/request/filtered_nfts_request.dart';
import 'package:satorio/domain/entities/nft_order_type.dart';
import 'package:satorio/util/extension.dart';

class NftsDataSourceImpl implements NftsDataSource {
  late final GetConnect _getConnect;
  final FirebaseDataSource _firebaseDataSource;

  NftsDataSourceImpl(this._firebaseDataSource);

  @override
  Future<void> init() async {
    String nftsUrl = await _firebaseDataSource.nftsApiUrl();

    _getConnect = GetConnect();
    _getConnect.baseUrl = nftsUrl;
  }

  // region NFT

  @override
  Future<List<NftItemModel>> allNfts({
    int? page,
    int? itemsPerPage,
  }) {
    Map<String, String>? query;
    if (page != null || itemsPerPage != null) {
      query = {};
      if (page != null) query['page'] = page.toString();
      if (itemsPerPage != null)
        query['items_per_page'] = itemsPerPage.toString();
    }

    return _getConnect
        .requestGet(
      'collections',
      query: query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['collections'] is Iterable) {
        return (jsonData['collections'] as Iterable)
            .map((element) => NftItemModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<List<NftItemModel>> nftsFiltered({
    int? page,
    int? itemsPerPage,
    List<String>? showIds,
  }) {
    return _getConnect
        .requestPost(
            'filtered',
            FilteredNftsRequest(NftOrderByType.timestamp, NftOrderType.desc,
                NftOrderOnSaleType.onSale, page, itemsPerPage, null, showIds))
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['nfts'] is Iterable) {
        return (jsonData['nfts'] as Iterable)
            .map((element) => NftItemModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<List<NftCategoryModel>> nftCategories() {
    return _getConnect
        .requestGet(
      'categories',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['categories'] is Iterable) {
        return (jsonData['categories'] as Iterable)
            .map((element) => NftCategoryModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<NftItemModel> nft(String mintAddress) {
    return _getConnect
        .requestGet(
      '$mintAddress',
    )
        .then((Response response) {
      return NftItemModel.fromJson(json.decode(response.bodyString!));
    });
  }

// end region
}
