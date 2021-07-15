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
import 'package:satorio/data/model/payload/payload_question_model.dart';
import 'package:satorio/data/model/payload/socket_message_factory.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/qr_result_model.dart';
import 'package:satorio/data/model/show_detail_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/show_season_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/model/transaction_model.dart';
import 'package:satorio/data/model/wallet_detail_model.dart';
import 'package:satorio/data/model/wallet_model.dart';
import 'package:satorio/data/request/empty_request.dart';
import 'package:satorio/data/request/forgot_password_request.dart';
import 'package:satorio/data/request/reset_password_request.dart';
import 'package:satorio/data/request/sign_in_request.dart';
import 'package:satorio/data/request/sign_up_request.dart';
import 'package:satorio/data/request/validate_reset_password_code_request.dart';
import 'package:satorio/data/request/verify_account_request.dart';
import 'package:satorio/data/response/auth_response.dart';
import 'package:satorio/data/response/error_response.dart';
import 'package:satorio/data/response/error_validation_response.dart';
import 'package:satorio/data/response/result_response.dart';
import 'package:satorio/data/response/socket_url_response.dart';

class ApiDataSourceImpl implements ApiDataSource {
  GetConnect _getConnect = GetConnect();
  AuthDataSource _authDataSource;

  ApiDataSourceImpl(this._authDataSource) {
    _getConnect.baseUrl = 'https://api.stage.sator.io/dev/';

    _getConnect.httpClient.addRequestModifier<Object?>((request) {
      String? token = _authDataSource.getAuthToken();
      if (token != null && token.isNotEmpty)
        request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
  }

  // region Internal

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
    Response utf8Response = response;
    // Response utf8Response = Response(
    //   request: response.request,
    //   statusCode: response.statusCode,
    //   bodyBytes: response.bodyBytes,
    //   bodyString: utf8.decode(response.bodyString!.runes.toList()),
    //   statusText: response.statusText,
    //   headers: response.headers,
    //   body: response.body,
    // );

    logResponse(utf8Response);

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

  void logResponse(Response response) {
    print('--------');

    // print('Request headers:');
    // response.request!.headers.forEach((key, value) {
    //   print('$key : $value');
    // });
    print(
        '${response.request!.method.toUpperCase()} ${response.request!.url} ${response.statusCode}');

    // print('Response headers:');
    // response.headers!.forEach((key, value) {
    //   print('$key : $value');
    // });
    print('${response.bodyString}');
    print('--------');
  }

  // endregion

  // region Local Auth

  @override
  Future<bool> isTokenExist() async {
    String? token = _authDataSource.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> authLogout() async {
    _authDataSource.clearAll();
    return;
  }

  // endregion

  // region Auth

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
  Future<bool> apiLogout() {
    return _requestPost(
      'auth/logout',
      EmptyRequest(),
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> verifyAccount(String code) {
    return _requestPost(
      'auth/verify-account',
      VerifyAccountRequest(code),
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> isVerified() {
    return _requestGet(
      'auth/is-verified',
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> resendCode() {
    return _requestPost(
      'auth/resend-otp',
      EmptyRequest(),
    ).then((Response response) {
      return response.isOk;
    });
  }

  @override
  Future<bool> refreshToken() {
    return _requestGet(
      'auth/refresh-token',
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

  // endregion

  // region Profile

  @override
  Future<ProfileModel> profile() {
    return _requestGet(
      'profile',
    ).then((Response response) {
      return ProfileModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  // endregion

  // region Wallet

  @override
  Future<List<AmountCurrencyModel>> walletBalance() {
    return _requestGet(
      'balance',
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
  Future<List<WalletModel>> wallets() {
    return _requestGet(
      'wallets',
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => WalletModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<WalletDetailModel> walletDetail(String detailPath) {
    return _requestGet(
      detailPath,
    ).then((Response response) {
      return WalletDetailModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<TransactionModel>> walletTransactions(String transactionsPath) {
    return _requestGet(
      transactionsPath,
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => TransactionModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  // endregion

  // region Shows

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
  Future<List<ShowModel>> showsFromCategory(String category) {
    return _requestGet(
      'shows/filter/$category',
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
  Future<ShowDetailModel> showDetail(String showId) {
    return _requestGet(
      'shows/$showId',
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      return ShowDetailModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<List<ShowSeasonModel>> showSeasons(String showId) {
    return _requestGet(
      'shows/$showId/episodes',
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      List<ShowSeasonModel> result;
      if (jsonData['data'] is Iterable)
        result = (jsonData['data'] as Iterable)
            .map((element) => ShowSeasonModel.fromJson(element))
            .toList();
      else
        result = [];
      result.sort((a, b) => a.seasonNumber.compareTo(b.seasonNumber));
      return result;
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

  // endregion

  // region Challenges

  @override
  Future<dynamic> loadShow(String showId) {
    return _requestGet(
      'shows/$showId',
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);

      return ShowModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<QrResultModel> getShowEpisodeByQR(String qrCodeId) {
    return _requestGet(
      'qrcodes/$qrCodeId',
    ).then((Response response) {
      Map jsonData = json.decode(response.bodyString!);

      return QrResultModel.fromJson(jsonData['data']);
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
  Future<bool> isChallengeActivated(String episodeId) {
    return _requestGet(
      'challenges/$episodeId/is-activated',
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<PayloadQuestionModel> showEpisodeQuizQuestion(String episodeId) {
    return _requestGet(
      'challenges/$episodeId/validation-question',
    ).then((Response response) {
      return PayloadQuestionModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<bool> showEpisodeQuizAnswer(String questionId, String answerId) {
    return _requestGet(
      'challenges/$questionId/check-answer/$answerId',
    ).then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  // endregion

  // region Quiz

  @override
  Future<String> quizSocketUrl(String challengeId) {
    return _requestGet(
      'quiz/$challengeId/play',
    ).then((Response response) {
      return SocketUrlResponse.fromJson(
              json.decode(response.bodyString!)['data'])
          .playUrl;
    });
  }

  // endregion

  // region Rewards

  @override
  Future<ClaimRewardModel> claimReward([String? claimRewardsPath]) {
    String path = (claimRewardsPath == null || claimRewardsPath.isEmpty)
        ? 'rewards/claim'
        : claimRewardsPath;

    return _requestGet(
      path,
    ).then((Response response) {
      return ClaimRewardModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  // endregion

  // region Socket

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

// endregion

}
