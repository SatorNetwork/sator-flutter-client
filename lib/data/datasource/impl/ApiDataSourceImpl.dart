import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';
import 'package:satorio/data/datasource/device_info_data_source.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';
import 'package:satorio/data/encrypt/ecrypt_manager.dart';
import 'package:satorio/data/model/activated_realm_model.dart';
import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/announcement_model.dart';
import 'package:satorio/data/model/challenge_model.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/claim_reward_model.dart';
import 'package:satorio/data/model/episode_activation_model.dart';
import 'package:satorio/data/model/nats_config_model.dart';
import 'package:satorio/data/model/nft_category_model.dart';
import 'package:satorio/data/model/nft_home_model.dart';
import 'package:satorio/data/model/nft_item_model.dart';
import 'package:satorio/data/model/payload/payload_question_model.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/puzzle/puzzle_game_model.dart';
import 'package:satorio/data/model/puzzle/puzzle_unlock_option_model.dart';
import 'package:satorio/data/model/qr_show_model.dart';
import 'package:satorio/data/model/realm_model.dart';
import 'package:satorio/data/model/referral_code_model.dart';
import 'package:satorio/data/model/review_model.dart';
import 'package:satorio/data/model/sao_wallet_config_model.dart';
import 'package:satorio/data/model/show_category_model.dart';
import 'package:satorio/data/model/show_detail_model.dart';
import 'package:satorio/data/model/show_episode_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/show_season_model.dart';
import 'package:satorio/data/model/stake_level_model.dart';
import 'package:satorio/data/model/transaction_model.dart';
import 'package:satorio/data/model/transfer_model.dart';
import 'package:satorio/data/model/wallet_detail_model.dart';
import 'package:satorio/data/model/wallet_model.dart';
import 'package:satorio/data/model/wallet_staking_model.dart';
import 'package:satorio/data/request/change_password_request.dart';
import 'package:satorio/data/request/confirm_transfer_request.dart';
import 'package:satorio/data/request/create_transfer_request.dart';
import 'package:satorio/data/request/empty_request.dart';
import 'package:satorio/data/request/forgot_password_request.dart';
import 'package:satorio/data/request/paid_unlock_request.dart';
import 'package:satorio/data/request/public_key_request.dart';
import 'package:satorio/data/request/puzzle_unlock_request.dart';
import 'package:satorio/data/request/rate_request.dart';
import 'package:satorio/data/request/register_iap_request.dart';
import 'package:satorio/data/request/register_token_request.dart';
import 'package:satorio/data/request/reset_password_request.dart';
import 'package:satorio/data/request/select_avatar_request.dart';
import 'package:satorio/data/request/send_invite_request.dart';
import 'package:satorio/data/request/send_tip_request.dart';
import 'package:satorio/data/request/sign_in_request.dart';
import 'package:satorio/data/request/sign_up_request.dart';
import 'package:satorio/data/request/tap_tile_request.dart';
import 'package:satorio/data/request/update_email_request.dart';
import 'package:satorio/data/request/update_username_request.dart';
import 'package:satorio/data/request/validate_reset_password_code_request.dart';
import 'package:satorio/data/request/verify_account_request.dart';
import 'package:satorio/data/request/verify_update_email_request.dart';
import 'package:satorio/data/request/wallet_stake_request.dart';
import 'package:satorio/data/request/write_review_request.dart';
import 'package:satorio/data/response/attempts_left_response.dart';
import 'package:satorio/data/response/auth_response.dart';
import 'package:satorio/data/response/possible_multiplier_response.dart';
import 'package:satorio/data/response/refresh_response.dart';
import 'package:satorio/data/response/result_response.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/util/extension.dart';

class ApiDataSourceImpl implements ApiDataSource {
  late final GetConnect _getConnect;
  final AuthDataSource _authDataSource;
  final FirebaseDataSource _firebaseDataSource;
  final DeviceInfoDataSource _deviceInfoDataSource;
  final EncryptManager _encryptManager;

  ApiDataSourceImpl(this._authDataSource, this._firebaseDataSource,
      this._deviceInfoDataSource, this._encryptManager);

  @override
  Future<void> init() async {
    await _firebaseDataSource.initRemoteConfig();
    await _firebaseDataSource.initNotifications();
    String baseUrl = await _firebaseDataSource.apiBaseUrl();

    _getConnect = GetConnect();

    _getConnect.baseUrl = baseUrl;
    _getConnect.timeout = Duration(seconds: 30);

    _getConnect.httpClient.addRequestModifier<Object?>((request) async {
      String? deviceId = await _deviceInfoDataSource.getDeviceId();

      if (deviceId.isNotEmpty) request.headers['Device-ID'] = deviceId;

      String? token = await _authDataSource.getAuthToken();
      if (token != null && token.isNotEmpty)
        request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
  }

  // region Internal
  Future<Response> _requestRefreshToken() async {
    String? refreshToken = await _authDataSource.getAuthRefreshToken();
    return _getConnect.request('auth/refresh-token', 'GET',
        headers: {'Authorization': 'Bearer $refreshToken'}).then(
      (Response response) => _getConnect.processResponse(response),
    );
  }

  // endregion

  // region Local Auth

  @override
  Future<bool> isTokenExist() async {
    String? token = await _authDataSource.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> isRefreshTokenExist() async {
    String? token = await _authDataSource.getAuthRefreshToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> removeAllTokens() async {
    await _authDataSource.clearToken();
    await _authDataSource.clearRefreshToken();

    return;
  }

  @override
  Future<void> removeAuthToken() {
    return _authDataSource.clearToken();
  }

  // endregion

  // region Auth

  @override
  Future<bool> signIn(String email, String password) {
    return _getConnect
        .requestPost(
      'auth/login',
      SignInRequest(email, password),
    )
        .then((Response response) {
      //for future separation on backend
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      //for future separation on backend
      String refreshToken =
          RefreshResponse.fromJson(json.decode(response.bodyString!))
              .refreshToken;
      _authDataSource.storeRefreshToken(refreshToken);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> signInViaRefreshToken() {
    return _requestRefreshToken().then((Response response) {
      //for future separation on backend
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      //for future separation on backend
      String refreshToken =
          RefreshResponse.fromJson(json.decode(response.bodyString!))
              .refreshToken;
      _authDataSource.storeRefreshToken(refreshToken);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _getConnect
        .requestPost(
      'auth/signup',
      SignUpRequest(email, password, username),
    )
        .then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> requestUpdateEmail(String email) {
    return _getConnect
        .requestPost('auth/request-update-email', UpdateEmailRequest(email))
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> updateUsername(String username) {
    return _getConnect
        .requestPost('auth/update-username', UpdateUsernameRequest(username))
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) {
    return _getConnect
        .requestPost('auth/change-password',
            ChangePasswordRequest(oldPassword, newPassword))
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> apiLogout() {
    return _getConnect
        .requestPost(
      'auth/logout',
      EmptyRequest(),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> verifyAccount(String code) {
    return _getConnect
        .requestPost(
      'auth/verify-account',
      VerifyAccountRequest(code),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> verifyUpdateEmail(String email, String code) {
    return _getConnect
        .requestPost(
      'auth/update-email',
      VerifyUpdateEmailRequest(email, code),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> isVerified() {
    return _getConnect
        .requestGet(
      'auth/is-verified',
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> selectAvatar(String avatarPath) {
    return _getConnect
        .requestPut(
      'profile/avatar',
      SelectAvatarRequest(avatarPath),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> resendCode() {
    return _getConnect
        .requestPost(
      'auth/resend-otp',
      EmptyRequest(),
    )
        .then((Response response) {
      return response.isOk;
    });
  }

  @override
  Future<bool> refreshToken() {
    return _getConnect
        .requestGet(
      'auth/refresh-token',
    )
        .then((Response response) {
      String token =
          AuthResponse.fromJson(json.decode(response.bodyString!)).accessToken;
      _authDataSource.storeAuthToken(token);
      return token.isNotEmpty;
    });
  }

  @override
  Future<bool> validateToken() {
    return _getConnect
        .requestGet(
      'auth',
    )
        .then((Response response) {
      if (response.isOk) {
        return ResultResponse.fromJson(json.decode(response.bodyString!))
            .result;
      } else {
        return false;
      }
    });
  }

  @override
  Future<bool> forgotPassword(String email) {
    return _getConnect
        .requestPost(
      'auth/forgot-password',
      ForgotPasswordRequest(email),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> validateResetPasswordCode(String email, String code) {
    return _getConnect
        .requestPost(
      'auth/validate-reset-password-code',
      ValidateResetPasswordCodeRequest(email, code),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> resetPassword(String email, String code, String newPassword) {
    return _getConnect
        .requestPost(
      'auth/reset-password',
      ResetPasswordRequest(email, code, newPassword),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  @override
  Future<bool> publicKey() {
    return _encryptManager
        .createRSAgetPublicKey()
        .then(
          (publicKey) => _getConnect.requestPost(
            'auth/user/public_key/register',
            PublicKeyRequest(publicKey),
          ),
        )
        .then((Response response) {
      return response.isOk;
    });
  }

  // endregion

  // region KYC

  Future<String> kycToken() {
    return _getConnect
        .requestGet(
      'auth/kyc/access_token',
    )
        .then((Response response) {
      return json.decode(response.bodyString!)['data'];
    });
  }

  // endregion

  // region Profile

  @override
  Future<ProfileModel> profile() {
    return _getConnect
        .requestGet(
      'profile',
    )
        .then((Response response) {
      return ProfileModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  // endregion

  // region Wallet

  @override
  Future<List<WalletModel>> wallets() {
    return _getConnect
        .requestGet(
      'wallets',
    )
        .then((Response response) {
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
  Future<SaoWalletConfigModel> saoWallet() {
    return _getConnect.requestGet('wallets/sao').then(
      (Response response) {
        return SaoWalletConfigModel.fromJson(
            json.decode(response.bodyString!)['data']);
      },
    );
  }

  @override
  Future<WalletDetailModel> walletDetail(String detailPath) {
    return _getConnect
        .requestGet(
      detailPath,
    )
        .then((Response response) {
      return WalletDetailModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<TransactionModel>> walletTransactions(String transactionsPath,
      {DateTime? from, DateTime? to}) {
    Map<String, String> query = {};
    if (from != null) query['from'] = from.toIso8601String();
    if (to != null) query['to'] = to.toIso8601String();

    return _getConnect
        .requestGet(
      transactionsPath,
      query: query.isEmpty ? null : query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => TransactionModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<TransferModel> createTransfer(
      String fromWalletId, String recipientAddress, double amount) {
    return _getConnect
        .requestPost(
      'wallets/$fromWalletId/create-transfer',
      CreateTransferRequest(recipientAddress, amount),
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      return TransferModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<bool> confirmTransfer(String fromWalletId, String txHash) {
    return _getConnect
        .requestPost(
      'wallets/$fromWalletId/confirm-transfer',
      ConfirmTransferRequest(txHash),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<double> possibleMultiplier(String walletId, double amount) {
    return _getConnect
        .requestPost(
      'wallets/$walletId/possible-multiplier',
      WalletStakeRequest(amount),
    )
        .then((Response response) {
      return PossibleMultiplierResponse.fromJson(
              json.decode(response.bodyString!))
          .possibleMultiplier;
    });
  }

  @override
  Future<bool> stake(String walletId, double amount) {
    return _getConnect
        .requestPost(
      'wallets/$walletId/stake',
      WalletStakeRequest(amount),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> unstake(String walletId) {
    return _getConnect
        .requestPost(
      'wallets/$walletId/unstake',
      EmptyRequest(),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<WalletStakingModel> getStake(String walletId) {
    return _getConnect
        .requestGet(
      'wallets/$walletId/stake',
    )
        .then((Response response) {
      return WalletStakingModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<StakeLevelModel>> stakeLevels() {
    return _getConnect
        .requestGet(
      'wallets/stake-levels',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] != null && jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => StakeLevelModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  // endregion

  // region Shows

  @override
  Future<List<ShowModel>> shows(bool? hasNfts, {int? page, int? itemsPerPage}) {
    Map<String, String>? query;
    if (page != null || itemsPerPage != null) {
      query = {};
      if (page != null) query['page'] = page.toString();
      if (hasNfts != null) query['with_nft'] = hasNfts.toString();
      if (itemsPerPage != null)
        query['items_per_page'] = itemsPerPage.toString();
    }

    return _getConnect
        .requestGet(
      'shows',
      query: query,
    )
        .then((Response response) {
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
  Future<List<ShowCategoryModel>> showsCategoryList({
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
      'shows/categories',
      query: query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ShowCategoryModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<List<ShowModel>> showsFromCategory(
    String category, {
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
      'shows/filter/$category',
      query: query,
    )
        .then((Response response) {
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
    return _getConnect
        .requestGet(
      'shows/$showId',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      return ShowDetailModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<ShowModel> show(String showId) {
    return _getConnect
        .requestGet(
      'shows/$showId',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      return ShowModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<List<ShowSeasonModel>> showSeasons(String showId) {
    return _getConnect
        .requestGet(
      'shows/$showId/episodes',
    )
        .then((Response response) {
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
  Future<ShowSeasonModel> seasonById(String showId, String seasonId) {
    return _getConnect
        .requestGet(
      'shows/$showId/seasons/$seasonId',
    )
        .then((Response response) {
      return ShowSeasonModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<ShowEpisodeModel> showEpisode(String showId, String episodeId) {
    return _getConnect
        .requestGet(
      'shows/$showId/episodes/$episodeId',
    )
        .then((Response response) {
      return ShowEpisodeModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<RealmModel> episodeById(String episodeId) {
    return _getConnect
        .requestGet(
      'shows/episodes/$episodeId',
    )
        .then((Response response) {
      return RealmModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<ReviewModel>> getReviews(String showId, String episodeId,
      {int? page, int? itemsPerPage}) {
    Map<String, String>? query;
    if (page != null || itemsPerPage != null) {
      query = {};
      if (page != null) query['page'] = page.toString();
      if (itemsPerPage != null)
        query['items_per_page'] = itemsPerPage.toString();
    }
    return _getConnect
        .requestGet(
      'shows/$showId/episodes/$episodeId/reviews',
      query: query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ReviewModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<List<ActivatedRealmModel>> getActivatedRealms(
      {int? page, int? itemsPerPage}) {
    Map<String, String>? query;
    if (page != null || itemsPerPage != null) {
      query = {};
      if (page != null) query['page'] = page.toString();
      if (itemsPerPage != null)
        query['items_per_page'] = itemsPerPage.toString();
    }
    return _getConnect
        .requestGet(
      'shows/episodes',
      query: query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ActivatedRealmModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  @override
  Future<List<ReviewModel>> getUserReviews({int? page, int? itemsPerPage}) {
    Map<String, String>? query;
    if (page != null || itemsPerPage != null) {
      query = {};
      if (page != null) query['page'] = page.toString();
      if (itemsPerPage != null)
        query['items_per_page'] = itemsPerPage.toString();
    }
    return _getConnect
        .requestGet(
      'shows/reviews',
      query: query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable)
        return (jsonData['data'] as Iterable)
            .map((element) => ReviewModel.fromJson(element))
            .toList();
      else
        return [];
    });
  }

  // endregion

  // region Challenges

  @override
  Future<ShowModel> loadShow(String showId) {
    return _getConnect
        .requestGet(
      'shows/$showId',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);

      return ShowModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<QrShowModel> getShowEpisodeByQR(String qrCodeId) {
    return _getConnect
        .requestGet(
      'qrcodes/$qrCodeId',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);

      return QrShowModel.fromJson(jsonData['data']);
    });
  }

  @override
  Future<bool> clapShow(String showId) {
    return _getConnect
        .requestPost(
      'shows/$showId/claps',
      EmptyRequest(),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<ChallengeModel> challenge(String challengeId) {
    return _getConnect
        .requestGet(
      'quiz_v2/challenges/$challengeId',
    )
        .then((Response response) {
      return ChallengeModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<ChallengeSimpleModel>> challenges(
      {int? page, int? itemsPerPage}) {
    Map<String, String>? query;
    if (page != null || itemsPerPage != null) {
      query = {};
      if (page != null) query['page'] = page.toString();
      if (itemsPerPage != null)
        query['items_per_page'] = itemsPerPage.toString();
    }

    return _getConnect
        .requestGet(
      'quiz_v2/challenges/sorted_by_players',
      query: query,
    )
        .then((Response response) {
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
  Future<EpisodeActivationModel> isEpisodeActivated(String episodeId) {
    return _getConnect
        .requestGet(
      'challenges/$episodeId/is-activated',
    )
        .then((Response response) {
      return EpisodeActivationModel.fromJson(json.decode(response.bodyString!));
    });
  }

  @override
  Future<EpisodeActivationModel> paidUnlockEpisode(
    String episodeId,
    String paidOption,
  ) {
    return _getConnect
        .requestPost(
      'challenges/unlock/$episodeId',
      PaidUnlockRequest(paidOption),
    )
        .then((Response response) {
      return EpisodeActivationModel.fromJson(json.decode(response.bodyString!));
    });
  }

  @override
  Future<int> showEpisodeAttemptsLeft(String episodeId) {
    return _getConnect
        .requestGet(
      'challenges/$episodeId/attempts-left',
    )
        .then((Response response) {
      return AttemptsLeftResponse.fromJson(
              json.decode(response.bodyString!)['data'])
          .attemptsLeft;
    });
  }

  @override
  Future<PayloadQuestionModel> showEpisodeQuizQuestion(String episodeId) {
    return _getConnect
        .requestGet(
      'challenges/$episodeId/validation-question',
    )
        .then((Response response) {
      return PayloadQuestionModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<bool> showEpisodeQuizAnswer(String questionId, String answerId) {
    return _getConnect
        .requestGet(
      'challenges/$questionId/check-answer/$answerId',
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> rateEpisode(String showId, String episodeId, int rate) {
    return _getConnect
        .requestPost(
      'shows/$showId/episodes/$episodeId/rate',
      RateRequest(rate),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> writeReview(
    String showId,
    String episodeId,
    int rating,
    String title,
    String review,
  ) {
    return _getConnect
        .requestPost(
      'shows/$showId/episodes/$episodeId/reviews',
      WriteReviewRequest(rating, title, review),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> sendReviewTip(String reviewId, double amount) {
    return _getConnect
        .requestPost(
      'shows/reviews/$reviewId/tips',
      SendTipRequest(amount),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<bool> rateReview(String reviewId, String ratingType) {
    return _getConnect
        .requestPost(
      'shows/reviews/$reviewId/$ratingType',
      EmptyRequest(),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  // endregion

  // region Quiz

  @override
  Future<NatsConfigModel> quizNats(String challengeId) {
    return _getConnect
        .requestGet(
      'quiz_v2/$challengeId/play',
    )
        .then((Response response) {
      return NatsConfigModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  // endregion

  // region Rewards

  @override
  Future<ClaimRewardModel> claimReward([String? claimRewardsPath]) {
    String path = (claimRewardsPath == null || claimRewardsPath.isEmpty)
        ? 'rewards/claim'
        : claimRewardsPath;

    return _getConnect
        .requestGet(
      path,
    )
        .then((Response response) {
      return ClaimRewardModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  // endregion

  // region Invitations

  @override
  Future<bool> sendInvite(String email) {
    return _getConnect
        .requestPost(
      'invitations',
      SendInviteRequest(email),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<ReferralCodeModel> getReferralCode() {
    return _getConnect
        .requestGet(
      'ref/my',
    )
        .then((Response response) {
      return ReferralCodeModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<bool> confirmReferralCode(String referralCode) {
    return _getConnect
        .requestPost(
      'ref/confirm/$referralCode',
      EmptyRequest(),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  // endregion

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
      'nft',
      query: query,
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable) {
        return (jsonData['data'] as Iterable)
            .map((element) => NftItemModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<List<NftItemModel>> userNfts(String walletAddress) {
    return _getConnect
        .requestGet(
      'nft/by_wallet_address/$walletAddress',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] != null && jsonData['data'] is Iterable) {
        return (jsonData['data'] as Iterable)
            .map((element) => NftItemModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<NftHomeModel> nftHome() {
    return _getConnect
        .requestGet(
      'nft/home',
    )
        .then((Response response) {
      return NftHomeModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<List<NftCategoryModel>> nftCategories() {
    return _getConnect
        .requestGet(
      'nft/categories',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable) {
        return (jsonData['data'] as Iterable)
            .map((element) => NftCategoryModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<List<NftItemModel>> nftItems(
    NftFilterType filterType,
    String objectId, {
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

    String pathParameter;
    switch (filterType) {
      case NftFilterType.NftCategory:
        pathParameter = 'category';
        break;
      case NftFilterType.Show:
        pathParameter = 'show';
        break;
      case NftFilterType.Episode:
        pathParameter = 'episode';
        break;
      case NftFilterType.User:
        pathParameter = 'user';
        break;
    }

    return _getConnect
        .requestGet(
      'nft/filter/$pathParameter/$objectId',
      query: query,
    )
        .then(
      (Response response) {
        Map jsonData = json.decode(response.bodyString!);
        if (jsonData['data'] is Iterable) {
          return (jsonData['data'] as Iterable)
              .map((element) => NftItemModel.fromJson(element))
              .toList();
        } else {
          return [];
        }
      },
    );
  }

  @override
  Future<NftItemModel> nftItem(String nftItemId) {
    return _getConnect
        .requestGet(
      'nft/$nftItemId',
    )
        .then((Response response) {
      return NftItemModel.fromJson(json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<bool> buyNftItem(String mintAddress) {
    return _getConnect
        .requestPost(
      'nft/$mintAddress/buy/marketplace',
      EmptyRequest(),
    )
        .then((Response response) {
      return response.isOk;
    });
  }

  @override
  Future<bool> buyNftIap(String transactionReceipt, String mintAddress) {
    return _getConnect
        .requestPost(
      'iap/register',
      RegisterIapRequest(transactionReceipt, mintAddress),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

  @override
  Future<List<PuzzleUnlockOptionModel>> puzzleOptions() {
    return _getConnect
        .requestGet('puzzle-game/unlock-options')
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] is Iterable) {
        return (jsonData['data'] as Iterable)
            .map((element) => PuzzleUnlockOptionModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<PuzzleGameModel?> puzzle(String episodeId) {
    return _getConnect
        .requestGet('puzzle-game/episode/$episodeId')
        .then((Response response) {
      return PuzzleGameModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<PuzzleGameModel> unlockPuzzle(
    String puzzleGameId,
    String unlockOption,
  ) {
    return _getConnect
        .requestPost(
      'puzzle-game/$puzzleGameId/unlock',
      PuzzleUnlockRequest(unlockOption),
    )
        .then((Response response) {
      return PuzzleGameModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<PuzzleGameModel> startPuzzle(String puzzleGameId) {
    return _getConnect
        .requestPost(
      'puzzle-game/$puzzleGameId/start',
      EmptyRequest(),
    )
        .then((Response response) {
      return PuzzleGameModel.fromJson(
          json.decode(response.bodyString!)['data']);
    });
  }

  @override
  Future<PuzzleGameModel> tapTile(String puzzleGameId, int x, int y) {
    return _getConnect
        .requestPost(
      'puzzle-game/$puzzleGameId/tap-tile',
      TapTileRequest(x, y),
    )
        .then(
      (Response response) {
        return PuzzleGameModel.fromJson(
            json.decode(response.bodyString!)['data']);
      },
    );
  }

// endregion

// region Firebase
  @override
  Future<bool> registerToken(String deviceId, String token) {
    return _getConnect
        .requestPost(
      'firebase/register_token',
      RegisterTokenRequest(deviceId, token),
    )
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }

//endregion

// region Announcements
  @override
  Future<List<AnnouncementModel>> unreadAnnouncements() {
    return _getConnect
        .requestGet(
      'announcement/unread',
    )
        .then((Response response) {
      Map jsonData = json.decode(response.bodyString!);
      if (jsonData['data'] != null && jsonData['data'] is Iterable) {
        return (jsonData['data'] as Iterable)
            .map((element) => AnnouncementModel.fromJson(element))
            .toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<bool> markAnnouncementAsRead(String announcementId) {
    return _getConnect
        .requestPost('announcement/$announcementId/read', EmptyRequest())
        .then((Response response) {
      return ResultResponse.fromJson(json.decode(response.bodyString!)).result;
    });
  }
//endregion

}
