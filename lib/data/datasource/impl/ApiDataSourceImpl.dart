import 'dart:collection';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';
import 'package:satorio/data/datasource/exception/api_error_exception.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/data/datasource/exception/api_validation_exception.dart';
import 'package:satorio/data/model/auth_response.dart';
import 'package:satorio/data/model/empty_request.dart';
import 'package:satorio/data/model/error_response.dart';
import 'package:satorio/data/model/error_validation_response.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/sign_in_request.dart';
import 'package:satorio/data/model/sign_up_request.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/model/wallet_balance_model.dart';

class ApiDataSourceImpl implements ApiDataSource {
  GetConnect _getConnect = GetConnect();
  AuthDataSource _authDataSource;

  ApiDataSourceImpl(this._authDataSource) {
    _getConnect.baseUrl = 'https://sator-api-n7vrw.ondigitalocean.app/';
  }

  Map<String, String> _getHeaders() {
    Map<String, String> headers = HashMap();

    String token = _authDataSource.getAuthToken();
    if (token != null && token.isNotEmpty)
      headers['Authorization'] = 'Bearer $token';

    return headers;
  }

  Future<Response> _requestGet(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect.get(path, query: query, headers: headers).then(
          (Response response) => _processResponse(response),
        );
  }

  Future<Response> _requestPost(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect
        .post(path, request.toJson(), query: query, headers: headers)
        .then(
          (Response response) => _processResponse(response),
        );
  }

  Future<Response> _requestPatch(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect
        .patch(path, request.toJson(), query: query, headers: headers)
        .then(
          (Response response) => _processResponse(response),
        );
  }

  Future<Response> _requestDelete(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  }) async {
    return await _getConnect.delete(path, query: query, headers: headers).then(
          (Response response) => _processResponse(response),
        );
  }

  Response _processResponse(Response response) {
    Response utf8Response = Response(
      request: response.request,
      statusCode: response.statusCode,
      bodyBytes: response.bodyBytes,
      bodyString: utf8.decode(response.bodyString.runes.toList()),
      statusText: response.statusText,
      headers: response.headers,
      body: response.body,
    );

    print('--------');
    // utf8Response.request.headers.forEach((key, value) {
    //   print('$key = $value');
    // });

    print(
        '${utf8Response.request.method.toUpperCase()} ${utf8Response.request.url} ${utf8Response.statusCode}');

    print('${utf8Response.bodyString}');
    print('--------');

    if (utf8Response.hasError) {
      switch (utf8Response.statusCode) {
        case 422:
          ErrorValidationResponse errorValidationResponse =
              ErrorValidationResponse.fromJson(
                  json.decode(utf8Response.bodyString));
          throw ApiValidationException(errorValidationResponse.validation);
          break;
        case 401:
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(json.decode(utf8Response.bodyString));
          throw ApiUnauthorizedException(errorResponse.error);
          break;
        default:
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(json.decode(utf8Response.bodyString));
          throw ApiErrorException(errorResponse.error);
          break;
      }
    }

    return utf8Response;
  }

  @override
  Future<bool> isTokenExist() async {
    String token = _authDataSource.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> signIn(String email, String password) {
    return _requestPost(
      'auth/login',
      SignInRequest(email, password),
      headers: _getHeaders(),
    ).then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token != null && token.isNotEmpty;
    });
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _requestPost(
      'auth/signup',
      SignUpRequest(email, password, username),
      headers: _getHeaders(),
    ).then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token != null && token.isNotEmpty;
    });
  }

  @override
  Future<bool> refreshToken() {
    return _requestPost(
      'auth/refresh-token',
      EmptyRequest(),
      headers: _getHeaders(),
    ).then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token != null && token.isNotEmpty;
    });
  }

  @override
  Future<ProfileModel> profile() {
    return _requestGet(
      'profile',
      headers: _getHeaders(),
    ).then((Response response) {
      return ProfileModel.fromJson(json.decode(response.bodyString)['data']);
    });
  }

  @override
  Future<WalletBalanceModel> walletBalance() {
    return _requestGet(
      'wallet/balance',
      headers: _getHeaders(),
    ).then((Response response) {
      return WalletBalanceModel.fromJson(
          json.decode(response.bodyString)['data']);
    });
  }

  @override
  Future<List<ShowModel>> shows({int page}) {
    Map<String, String> query;
    if (page != null) {
      query = {};
      query['page'] = page.toString();
    }

    return _requestGet('shows', headers: _getHeaders(), query: query)
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ShowModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<List<ChallengeSimpleModel>> showChallenges({int page, String id}) {
    Map<String, String> query;
    if (page != null) {
      query = {};
      query['page'] = page.toString();
    }

    return _requestGet('shows/$id/challenges', headers: _getHeaders(), query: query)
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ChallengeSimpleModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<void> logout() async {
    _authDataSource.clearAll();
    return;
  }
}
