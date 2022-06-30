import 'dart:ui';

import 'package:dart_nats/dart_nats.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/device_info_data_source.dart';
import 'package:satorio/data/datasource/exception/api_error_exception.dart';
import 'package:satorio/data/datasource/exception/api_kyc_exception.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/data/datasource/feed_data_source.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';
import 'package:satorio/data/datasource/in_app_purchase_data_source.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/datasource/nats_data_source.dart';
import 'package:satorio/data/datasource/nfts_data_source.dart';
import 'package:satorio/data/datasource/solana_data_source.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/nats_config.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_game.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_unlock_option.dart';
import 'package:satorio/domain/entities/qr_show.dart';
import 'package:satorio/domain/entities/referral_code.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_category.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/entities/stake_level.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/util/getx_extension.dart';

class SatorioRepositoryImpl implements SatorioRepository {
  final ApiDataSource _apiDataSource;
  final NftsDataSource _nftsDataSource;
  final FirebaseDataSource _firebaseDataSource;
  final LocalDataSource _localDataSource;
  final NatsDataSource _natsDataSource;
  final InAppPurchaseDataSource _inAppPurchaseDataSource;
  final FeedDataSource _feedDataSource;
  final DeviceInfoDataSource _deviceInfoDataSource;
  final SolanaDataSource _solanaDataSource;

  final RxBool _init = false.obs;

  SatorioRepositoryImpl(
    this._apiDataSource,
    this._nftsDataSource,
    this._localDataSource,
    this._firebaseDataSource,
    this._natsDataSource,
    this._inAppPurchaseDataSource,
    this._feedDataSource,
    this._deviceInfoDataSource,
    this._solanaDataSource,
  ) {
    _localDataSource
        .init()
        .then((value) => _apiDataSource.init())
        .then((value) => _nftsDataSource.init())
        .then((value) => _inAppPurchaseDataSource.init())
        .then((value) => _solanaDataSource.init())
        .then((value) => _init.value = true);
  }

  _handleException(Exception exception) {
    if (exception is ApiErrorException) {
      _handleApiErrorException(exception);
    } else if (exception is ApiUnauthorizedException) {
      _handleApiUnauthorizedException(exception);
    } else if (exception is ApiKycException) {
      _handleApiKycException();
    } else {
      throw exception;
    }
  }

  void _handleApiErrorException(ApiErrorException exception) {
    Get.snackbarMessage(
      'txt_oops'.tr,
      exception.errorMessage,
    );
  }

  void _handleApiUnauthorizedException(ApiUnauthorizedException exception) {
    clearDBandAccessToken().then(
      (value) {
        Get.offAll(
          () => LoginPage(),
          binding: LoginBinding(),
          arguments: LoginArgument(null),
        );
        Get.snackbarMessage(
          'txt_oops'.tr,
          exception.errorMessage,
        );
      },
    );
  }

  void _handleApiKycException() {
    _apiDataSource.kycToken().then((String kycToken) {
      print('KYC token = $kycToken');

      SNSMobileSDK.init(
        kycToken,
        () => _apiDataSource.kycToken(),
      )
          .withLocale(
            Locale('en'),
          )
          .withDebug(kDebugMode)
          .build()
          .launch();
    });
  }

  @override
  RxBool get isInited => _init;

  @override
  Future<void> initRemoteConfig() {
    return _firebaseDataSource
        .initRemoteConfig()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String> firebaseChatChild() {
    return _firebaseDataSource
        .firebaseChatChild()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String> firebaseUrl() {
    return _firebaseDataSource
        .firebaseUrl()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String> claimRewardsText() {
    return _firebaseDataSource
        .claimRewardText()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String> quizHeadTitleText() {
    return _firebaseDataSource
        .quizHeadTitleText()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String> quizHeadMessageText() {
    return _firebaseDataSource
        .quizHeadMessageText()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<int> appVersion() {
    return _firebaseDataSource
        .appVersion()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String> nftsMarketplaceUrl() {
    return _firebaseDataSource
        .nftsMarketplaceUrl()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> clearDBandAccessToken() {
    return _localDataSource
        .clear()
        .then((value) => _apiDataSource.removeAuthToken());
  }

  @override
  Future<void> clearDBandAllTokens() {
    return _localDataSource
        .clear()
        .then((value) => _apiDataSource.removeAllTokens());
  }

  @override
  Future<void> clearAllTokens() {
    return _apiDataSource.removeAllTokens();
  }

  @override
  Future<void> removeTokenIsBiometricEnabled() {
    return _apiDataSource.removeAuthToken();
  }

  @override
  Future<bool> isTokenValid() {
    return _apiDataSource.isTokenExist().then((isTokenExist) {
      if (isTokenExist)
        return _apiDataSource
            .refreshToken()
            .catchError((value) => _handleException(value));
      else
        return isTokenExist;
    });
  }

  @override
  Future<bool> signInViaRefreshToken() {
    return _apiDataSource.isRefreshTokenExist().then((isExist) {
      if (isExist)
        return _apiDataSource
            .signInViaRefreshToken()
            .catchError((error) => _handleException(error));
      else
        return isExist;
    });
  }

  @override
  Future<bool> validateToken() {
    return _apiDataSource.validateToken();
  }

  @override
  Future<bool> isRefreshTokenExist() {
    return _apiDataSource
        .isRefreshTokenExist()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> signIn(String email, String password) {
    return _apiDataSource
        .signIn(email, password)
        .then((value) => _apiDataSource.publicKey())
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _apiDataSource
        .signUp(email, password, username)
        .then((value) => _apiDataSource.publicKey())
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> requestUpdateEmail(String email) {
    return _apiDataSource
        .requestUpdateEmail(email)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> updateUsername(String username) {
    return _apiDataSource
        .updateUsername(username)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) {
    return _apiDataSource
        .changePassword(oldPassword, newPassword)
        .catchError((value) => _handleException(value));
  }

  Future<bool> verifyAccount(String code) {
    return _apiDataSource
        .verifyAccount(code)
        .catchError((value) => _handleException(value));
  }

  Future<bool> verifyUpdateEmail(String email, String code) {
    return _apiDataSource
        .verifyUpdateEmail(email, code)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> isVerified() {
    return _apiDataSource
        .isVerified()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> isOnBoarded() {
    return _localDataSource.isOnBoarded();
  }

  @override
  Future<void> markOnBoarded() {
    return _localDataSource.markOnBoarded();
  }

  @override
  Future<bool> isBiometricEnabled() {
    return _localDataSource.isBiometricEnabled();
  }

  @override
  Future<void> markIsBiometricEnabled(bool isBiometricEnabled) {
    return _localDataSource.markIsBiometricEnabled(isBiometricEnabled);
  }

  @override
  Future<void> markIsBiometricUserDisabled() {
    return _localDataSource.markIsBiometricUserDisabled();
  }

  @override
  Future<bool?> isBiometricUserDisabled() {
    return _localDataSource.isBiometricUserDisabled();
  }

  @override
  Future<bool> selectAvatar(String avatarPath) {
    return _apiDataSource
        .selectAvatar(avatarPath)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> resendCode() {
    return _apiDataSource
        .resendCode()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> forgotPassword(String email) {
    return _apiDataSource
        .forgotPassword(email)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> validateResetPasswordCode(String email, String code) {
    return _apiDataSource
        .validateResetPasswordCode(email, code)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> resetPassword(String email, String code, String newPassword) {
    return _apiDataSource
        .resetPassword(email, code, newPassword)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Show>> shows(bool? hasNfts, {int? page, int? itemsPerPage}) {
    return _apiDataSource
        .shows(hasNfts, page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<ShowCategory>> showsCategoryList({
    int? page,
    int? itemsPerPage,
  }) {
    return _apiDataSource
        .showsCategoryList(page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Show>> showsFromCategory(
    String category, {
    int? page,
    int? itemsPerPage,
  }) {
    return _apiDataSource
        .showsFromCategory(category, page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<ShowDetail> showDetail(String showId) {
    return _apiDataSource
        .showDetail(showId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<Show> show(String showId) {
    return _apiDataSource
        .show(showId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<ShowSeason>> showSeasons(String showId) {
    return _apiDataSource
        .showSeasons(showId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<ShowSeason> seasonById(String showId, String seasonId) {
    return _apiDataSource
        .seasonById(showId, seasonId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<ShowEpisode> showEpisode(String showId, String episodeId) {
    return _apiDataSource
        .showEpisode(showId, episodeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<Show> loadShow(String showId) {
    return _apiDataSource
        .loadShow(showId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<QrShow> getShowEpisodeByQR(String qrCodeId) {
    return _apiDataSource
        .getShowEpisodeByQR(qrCodeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> clapShow(String showId) {
    return _apiDataSource
        .clapShow(showId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> logout() {
    return _apiDataSource
        .apiLogout()
        .then(
          (value) => clearDBandAllTokens(),
        )
        .then((value) => markIsBiometricUserDisabled())
        .then(
      (value) {
        Get.offAll(
          () => LoginPage(),
          binding: LoginBinding(),
          arguments: LoginArgument(null),
        );
      },
    );
  }

  @override
  Future<Challenge> challenge(String challengeId) {
    return _apiDataSource
        .challenge(challengeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<ChallengeSimple>> challenges({int? page, int? itemsPerPage}) {
    return _apiDataSource
        .challenges(page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<EpisodeActivation> isEpisodeActivated(String episodeId) {
    return _apiDataSource
        .isEpisodeActivated(episodeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<EpisodeActivation> paidUnlockEpisode(
    String episodeId,
    String paidOption,
  ) {
    return _apiDataSource
        .paidUnlockEpisode(episodeId, paidOption)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<int> showEpisodeAttemptsLeft(String episodeId) {
    return _apiDataSource
        .showEpisodeAttemptsLeft(episodeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<PayloadQuestion> showEpisodeQuizQuestion(String episodeId) {
    return _apiDataSource
        .showEpisodeQuizQuestion(episodeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> showEpisodeQuizAnswer(String questionId, String answerId) {
    return _apiDataSource
        .showEpisodeQuizAnswer(questionId, answerId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> rateEpisode(String showId, String episodeId, int rate) {
    return _apiDataSource
        .rateEpisode(showId, episodeId, rate)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> writeReview(
    String showId,
    String episodeId,
    int rating,
    String title,
    String review,
  ) {
    return _apiDataSource
        .writeReview(showId, episodeId, rating, title, review)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> sendReviewTip(String reviewId, double amount) {
    return _apiDataSource
        .sendReviewTip(reviewId, amount)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> rateReview(String reviewId, String ratingType) {
    return _apiDataSource
        .rateReview(reviewId, ratingType)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<NatsConfig> quizNats(String challengeId) {
    return _apiDataSource
        .quizNats(challengeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<Subscription> subscribeNats(String url, String subject) {
    return _natsDataSource.subscribe(url, subject);
  }

  @override
  Future<void> unsubscribeNats(Subscription subscription) {
    return _natsDataSource.unsubscribe(subscription);
  }

  @override
  Future<void> sendAnswer(
    String subject,
    String serverPublicKey,
    String questionId,
    String answerId,
  ) {
    return _natsDataSource.sendAnswer(
        subject, serverPublicKey, questionId, answerId);
  }

  @override
  Future<void> sendPing(String subject, String serverPublicKey) {
    return _natsDataSource.sendPing(subject, serverPublicKey);
  }

  @override
  Future<String> decryptData(String data) {
    return _natsDataSource.decryptReceivedMessage(data);
  }

  @override
  Future<ClaimReward> claimReward([String? claimRewardsPath]) {
    return _apiDataSource
        .claimReward(claimRewardsPath)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> sendInvite(String email) {
    return _apiDataSource
        .sendInvite(email)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<ReferralCode> getReferralCode() {
    return _apiDataSource
        .getReferralCode()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> confirmReferralCode(String referralCode) {
    return _apiDataSource
        .confirmReferralCode(referralCode)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> updateProfile() {
    return _apiDataSource
        .profile()
        .then(
          (Profile profile) => _localDataSource.saveProfile(profile),
        )
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> updateWalletBalance() {
    return _apiDataSource
        .walletBalance()
        .then(
          (List<AmountCurrency> amountCurrencies) =>
              _localDataSource.saveWalletBalance(amountCurrencies),
        )
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Wallet>> updateWallets() {
    return _apiDataSource.wallets().then((List<Wallet> wallets) {
      _localDataSource.saveWallets(wallets);
      return wallets;
    }).catchError((value) => _handleException(value));
  }

  @override
  Future<void> updateWalletDetail(String detailPath) {
    return _apiDataSource.walletDetail(detailPath).then(
      (WalletDetail walletDetail) {
        final AmountCurrency? amountCurrency = walletDetail.balance
            .firstWhereOrNull(
                (element) => element.currency.toUpperCase() == 'SAO');

        if (walletDetail.isSolana && amountCurrency != null) {
          return _solanaDataSource
              .balanceSAO(walletDetail.solanaAccountAddress)
              .then(
            (amount) {
              if (amount != null) {
                amountCurrency.amount = amount;
              }
              return _localDataSource.saveWalletDetail(walletDetail);
            },
          );
        } else {
          return _localDataSource.saveWalletDetail(walletDetail);
        }
      },
    ).catchError((value) => _handleException(value));
  }

  @override
  Future<void> updateWalletTransactions(
    Wallet wallet, {
    DateTime? from,
    DateTime? to,
  }) {
    return _apiDataSource
        .walletDetail(wallet.detailsUrl)
        .then((WalletDetail walletDetail) {
      if (walletDetail.isSolana) {
        return _solanaDataSource
            .transactionsATA(
          walletDetail.id,
          walletDetail.solanaAccountAddress,
        )
            .then((List<Transaction> transactions) {
          return transactions.isNotEmpty
              ? _localDataSource.cleanTransactions(walletDetail.id).then(
                  (value) => _localDataSource.saveTransactions(transactions))
              : Future.value();
        });
      } else {
        return _apiDataSource
            .walletTransactions(wallet.transactionsUrl, from: from, to: to)
            .then(
              (List<Transaction> transactions) =>
                  _localDataSource.saveTransactions(transactions),
            );
      }
    });
  }

  @override
  Future<Transfer> createTransfer(
    String fromWalletId,
    String recipientAddress,
    double amount,
  ) {
    return _apiDataSource
        .createTransfer(fromWalletId, recipientAddress, amount)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> confirmTransfer(String fromWalletId, String txHash) {
    return _apiDataSource
        .confirmTransfer(fromWalletId, txHash)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<double> possibleMultiplier(String walletId, double amount) {
    return _apiDataSource
        .possibleMultiplier(walletId, amount)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> stake(String walletId, double amount) {
    return _apiDataSource
        .stake(walletId, amount)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> unstake(String walletId) {
    return _apiDataSource
        .unstake(walletId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<WalletStaking> getStake(String walletId) {
    return _apiDataSource
        .getStake(walletId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<StakeLevel>> stakeLevels() {
    return _apiDataSource
        .stakeLevels()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Review>> getReviews(String showId, String episodeId,
      {int? page, int? itemsPerPage}) {
    return _apiDataSource
        .getReviews(showId, episodeId, page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Review>> getUserReviews({int? page, int? itemsPerPage}) {
    return _apiDataSource
        .getUserReviews(page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<ActivatedRealm>> getActivatedRealms({
    int? page,
    int? itemsPerPage,
  }) {
    return _apiDataSource
        .getActivatedRealms(page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<NftItem>> allNfts({
    int? page,
    int? itemsPerPage,
  }) {
    return _nftsDataSource
        .allNfts(page: page, itemsPerPage: itemsPerPage)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<NftItem>> userNfts(String walletAddress) {
    return _apiDataSource
        .userNfts(walletAddress)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<NftHome> nftHome() {
    return _apiDataSource
        .nftHome()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<NftCategory>> nftCategories() {
    return _apiDataSource
        .nftCategories()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<NftItem>> nftItems(
    NftFilterType filterType,
    String objectId, {
    int? page,
    int? itemsPerPage,
  }) {
    return _apiDataSource
        .nftItems(
          filterType,
          objectId,
          page: page,
          itemsPerPage: itemsPerPage,
        )
        .catchError((value) => _handleException(value));
  }

  @override
  Future<NftItem> nftItem(String nftItemId) {
    return _apiDataSource
        .nftItem(nftItemId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> buyNftItem(String mintAddress) {
    return _apiDataSource
        .buyNftItem(mintAddress)
        .catchError((value) => _handleException(value));
  }

  //

  @override
  ValueListenable profileListenable() {
    return _localDataSource.profileListenable();
  }

  @override
  ValueListenable walletBalanceListenable() {
    return _localDataSource.walletBalanceListenable();
  }

  @override
  ValueListenable walletsListenable() {
    return _localDataSource.walletsListenable();
  }

  @override
  ValueListenable walletDetailsListenable(List<String>? ids) {
    return _localDataSource.walletDetailsListenable(ids);
  }

  @override
  ValueListenable transactionsListenable() {
    return _localDataSource.transactionsListenable();
  }

  @override
  ValueListenable rssItemsListenable() {
    return _localDataSource.rssItemsListenable();
  }

  //TODO:  move to region
  @override
  Future<List<NftItem>> nftsFiltered({
    int? page,
    int? itemsPerPage,
    List<String>? showIds,
    String? orderType,
    String? owner,
  }) {
    return _nftsDataSource
        .nftsFiltered(
            page: page,
            itemsPerPage: itemsPerPage,
            showIds: showIds,
            orderType: orderType,
            owner: owner)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<NftItem> nft(String mintAddress) {
    return _nftsDataSource
        .nft(mintAddress)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> buyNftIap(String transactionReceipt, String mintAddress) {
    return _apiDataSource
        .buyNftIap(transactionReceipt, mintAddress)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<PuzzleUnlockOption>> puzzleOptions() {
    return _apiDataSource
        .puzzleOptions()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<PuzzleGame> unlockPuzzle(String puzzleGameId, String unlockOption) {
    return _apiDataSource
        .unlockPuzzle(puzzleGameId, unlockOption)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<PuzzleGame?> puzzle(String episodeId) {
    return _apiDataSource.puzzle(episodeId).catchError((value) => null);
  }

  @override
  Future<PuzzleGame> startPuzzle(String puzzleGameId) {
    return _apiDataSource
        .startPuzzle(puzzleGameId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<PuzzleGame> tapTile(String puzzleGameId, int x, int y) {
    return _apiDataSource.tapTile(puzzleGameId, x, y);
  }

  @override
  Future<List<IAPItem>> getProducts(List<String> productsIds) {
    return _inAppPurchaseDataSource
        .getProducts(productsIds)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> buyInAppProduct(String id) {
    return _inAppPurchaseDataSource
        .buyInAppProduct(id)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String?> initializePurchase() {
    return _inAppPurchaseDataSource
        .initializePurchase()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<PurchasedItem>?> purchaseHistory() {
    return _inAppPurchaseDataSource
        .purchaseHistory()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> consumeAll() {
    return _inAppPurchaseDataSource
        .consumeAll()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<String?> finishTransaction(
      PurchasedItem purchasedItem, bool isConsumable) {
    return _inAppPurchaseDataSource
        .finishTransaction(purchasedItem, isConsumable)
        .catchError((value) => _handleException(value));
  }

  @override
  Future inAppProductsIds() {
    return _firebaseDataSource
        .inAppProductsIds()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> updateRssItems() async {
    final lastRssUpdateTime = await _localDataSource.lastRssUpdateTime();
    if (lastRssUpdateTime == null ||
        DateTime.now().difference(lastRssUpdateTime).inDays >= 1) {
      return _feedDataSource.rssItems().then(
            (value) => _localDataSource.saveRssItems(value),
          );
    } else {
      return Future.value();
    }
  }

  @override
  Future<String?> fcmToken() {
    return _firebaseDataSource.fcmToken().then((fcmToken) {
      _deviceInfoDataSource.getDeviceId().then((deviceId) {
        _apiDataSource.registerToken(deviceId, fcmToken!);
      });
    }).catchError((value) => _handleException(value));
  }

  @override
  Future<String> solanaClusterName() {
    return _firebaseDataSource.solanaClusterName();
  }

  @override
  Future<bool> isTokenLockEnabled() {
    return _firebaseDataSource.isTokenLockEnabled();
  }

  @override
  Future<bool> isPaidUnlockEnabled() {
    return _firebaseDataSource.isPaidUnlockEnabled();
  }

  @override
  Future<bool> isTipsEnabled() {
    return _firebaseDataSource.isTipsEnabled();
  }

  @override
  Future<bool> isBottomSheetPtsEnabled() {
    return _firebaseDataSource.isBottomSheetPtsEnabled();
  }

  @override
  Future<bool> isWinnerScoresEnabled() {
    return _firebaseDataSource.isWinnerScoresEnabled();
  }

  @override
  Future<bool> isHomeBalanceEnabled() {
    return _firebaseDataSource.isHomeBalanceEnabled();
  }

  @override
  Future<bool> isRealmEarnedSaoEnabled() {
    return _firebaseDataSource.isRealmEarnedSaoEnabled();
  }
}
