import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';
import 'package:satorio/data/datasource/exception/api_error_exception.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/data/datasource/exception/api_validation_exception.dart';
import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/challenge_model.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/claim_reward_model.dart';
import 'package:satorio/data/model/payload/payload_answer_model.dart';
import 'package:satorio/data/model/payload/socket_message_factory.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/request/empty_request.dart';
import 'package:satorio/data/request/forgot_password_request.dart';
import 'package:satorio/data/request/reset_password_request.dart';
import 'package:satorio/data/request/sign_in_request.dart';
import 'package:satorio/data/request/sign_up_request.dart';
import 'package:satorio/data/request/validate_reset_password_code_request.dart';
import 'package:satorio/data/request/verify_account_request.dart';
import 'package:satorio/data/request/validate_reset_password_code_request.dart';
import 'package:satorio/data/response/auth_response.dart';
import 'package:satorio/data/response/error_response.dart';
import 'package:satorio/data/response/error_validation_response.dart';
import 'package:satorio/data/response/result_response.dart';
import 'package:satorio/data/response/socket_url_response.dart';
import 'package:satorio/data/response/verify_account_response.dart';

class ApiDataSourceImpl implements ApiDataSource {
  GetConnect _getConnect = GetConnect();
  AuthDataSource _authDataSource;

  ApiDataSourceImpl(this._authDataSource) {
    _getConnect.baseUrl = 'https://sator-api-stage-93k39.ondigitalocean.app/';

    _getConnect.httpClient.addRequestModifier<Object?>((request) {
      String? token = _authDataSource.getAuthToken();
      if (token != null && token.isNotEmpty)
        request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
  }

  Future<Response> _requestGet(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return await _getConnect.get(path, query: query).then(
          (Response response) => _processResponse(response),
        );
  }

  Future<Response> _requestPost(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic>? query,
  }) async {
    return await _getConnect.post(path, request.toJson(), query: query).then(
          (Response response) => _processResponse(response),
        );
  }

  Future<Response> _requestPatch(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic>? query,
  }) async {
    return await _getConnect.patch(path, request.toJson(), query: query).then(
          (Response response) => _processResponse(response),
        );
  }

  Future<Response> _requestDelete(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return await _getConnect.delete(path, query: query).then(
          (Response response) => _processResponse(response),
        );
  }

  Future<void> _sendViaSocket(GetSocket? socket, ToJsonInterface data) async {
    if (socket != null) {
      String jsonData = json.encode(data.toJson());
      print('onSend $jsonData');
      socket.send(jsonData);
    }
    return;
  }

  Response _processResponse(Response response) {
    Response utf8Response = Response(
      request: response.request,
      statusCode: response.statusCode,
      bodyBytes: response.bodyBytes,
      bodyString: utf8.decode(response.bodyString!.runes.toList()),
      statusText: response.statusText,
      headers: response.headers,
      body: response.body,
    );

    print('--------');

    print(
        '${utf8Response.request!.method.toUpperCase()} ${utf8Response.request!.url} ${utf8Response.statusCode}');

    print('${utf8Response.bodyString}');
    print('--------');

    if (utf8Response.hasError) {
      switch (utf8Response.statusCode) {
        case 422:
          ErrorValidationResponse errorValidationResponse =
              ErrorValidationResponse.fromJson(
                  json.decode(utf8Response.bodyString!));
          throw ApiValidationException(errorValidationResponse.validation);
        case 401:
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(json.decode(utf8Response.bodyString!));
          throw ApiUnauthorizedException(errorResponse.error);
        default:
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(json.decode(utf8Response.bodyString!));
          throw ApiErrorException(errorResponse.error);
      }
    }

    return utf8Response;
  }

  @override
  Future<bool> isTokenExist() async {
    String? token = _authDataSource.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> signIn(String email, String password) {
    return _requestPost(
      'auth/login',
      SignInRequest(email, password),
    ).then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _requestPost(
      'auth/signup',
      SignUpRequest(email, password, username),
    ).then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> verifyAccount(String otp) {
    return _requestPost(
      'auth/verify-account',
      VerifyAccountRequest(otp),
    ).then((Response response) {
      return VerifyAccountResponse.fromJson(json.decode(response.bodyString!)).isVerify;
    });
  }

  @override
  Future<bool> refreshToken() {
    return _requestPost(
      'auth/refresh-token',
      EmptyRequest(),
    ).then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> forgotPassword(String email) {
    return _requestPost(
      'auth/forgot-password',
      ForgotPasswordRequest(email),
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> validateResetPasswordCode(String email, String code) {
    return _requestPost(
      'auth/validate-reset-password-code',
      ValidateResetPasswordCodeRequest(email, code),
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> resetPassword(String email, String code, String newPassword) {
    return _requestPost(
      'auth/reset-password',
      ResetPasswordRequest(email, code, newPassword),
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<ProfileModel> profile() {
    return _requestGet(
      'profile',
    ).then((Response response) {
      return ProfileModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<AmountCurrencyModel>> wallet() {
    return _requestGet(
      'wallet/balance',
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => AmountCurrencyModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<List<ShowModel>> shows({int? page}) {
    Map<String, String>? query;
    if (page != null) {
      query = {};
      query['page'] = page.toString();
    }

    return _requestGet(
      'shows',
      query: query,
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ShowModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<List<ChallengeSimpleModel>> showChallenges(String showId,
      {int? page}) {
    Map<String, String>? query;
    if (page != null) {
      query = {};
      query['page'] = page.toString();
    }

    return _requestGet(
      'shows/$showId/challenges',
      query: query,
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ChallengeSimpleModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<ChallengeModel> challenge(String challengeId) {
    return _requestGet(
      'challenges/$challengeId',
    ).then((Response response) {
      return ChallengeModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<void> logout() async {
    _authDataSource.clearAll();
    return;
  }

  @override
  Future<String> socketUrl(String challengeId) {
    return _requestGet(
      'quiz/$challengeId/play',
    ).then((Response response) {
      return SocketUrlResponse.fromJson(
              json.decode(response.bodyString!)['data'])
          .playUrl;
    });
  }

  @override
  Future<GetSocket> createSocket(String url) async {
    return GetConnect().socket(url);
  }

  @override
  Future<void> sendAnswer(
    GetSocket? socket,
    String questionId,
    String answerId,
  ) async {
    _sendViaSocket(
      socket,
      SocketMessageAnswerModel(
        PayloadAnswerModel(questionId, answerId),
      ),
    );
    return;
  }

  @override
  Future<ClaimRewardModel> claimReward() {
    return _requestGet(
      'rewards/claim',
    ).then((Response response) {
      return ClaimRewardModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }
}
