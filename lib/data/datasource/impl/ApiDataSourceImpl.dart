import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/model/to_json_interface.dart';

class ApiDataSourceImpl extends ApiDataSource {

  static const baseUrl = 'https://exmaple.com';
  GetConnect _getConnect = GetConnect();

  Future<Response> _requestGet(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect.get(baseUrl + path,
        query: query, headers: headers);
  }

  Future<Response> _requestPost(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect.post(baseUrl + path, request.toJson(),
        query: query, headers: headers);
  }

  Future<Response> _requestPatch(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect.patch(baseUrl + path, request.toJson(),
        query: query, headers: headers);
  }

  Future<Response> _requestDelete(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect.delete(baseUrl + path,
        query: query, headers: headers);
  }
}
