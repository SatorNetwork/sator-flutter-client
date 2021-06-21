import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/exception/api_error_exception.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/login_page.dart';

class SatorioRepositoryImpl implements SatorioRepository {
  final ApiDataSource _apiDataSource;
  final LocalDataSource _localDataSource;

  SatorioRepositoryImpl(this._apiDataSource, this._localDataSource) {
    _localDataSource.init();
  }

  _handleException(Exception exception) {
    if (exception is ApiErrorException) {
      Get.dialog(
        DefaultDialog(
          'txt_oops'.tr,
          exception.errorMessage,
          'txt_ok'.tr,
          onPressed: () {
            Get.back();
          },
        ),
      );
    } else if (exception is ApiUnauthorizedException) {
      _localLogout();
      Get.snackbar('txt_oops'.tr, exception.errorMessage);
    } else {
      throw exception;
    }
  }

  Future<void> _localLogout() {
    return _localDataSource
        .clear()
        .then((value) => _apiDataSource.authLogout())
        .then((value) {
      Get.offAll(() => LoginPage(), binding: LoginBinding());
      return;
    });
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
  Future<bool> signIn(String email, String password) {
    return _apiDataSource
        .signIn(email, password)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _apiDataSource
        .signUp(email, password, username)
        .catchError((value) => _handleException(value));
  }

  Future<bool> verifyAccount(String code) {
    return _apiDataSource
        .verifyAccount(code)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> isVerified() {
    return _apiDataSource
        .isVerified()
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
  Future<void> updateProfile() {
    return _apiDataSource
        .profile()
        .then(
          (Profile profile) => _localDataSource.saveProfile(profile),
        )
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> updateWallet() {
    return _apiDataSource
        .wallet()
        .then(
          (List<AmountCurrency> amountCurrencies) =>
              _localDataSource.saveWallet(amountCurrencies),
        )
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Show>> shows({int? page}) {
    return _apiDataSource
        .shows(page: page)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<ChallengeSimple>> showChallenges(String showId, {int? page}) {
    return _apiDataSource
        .showChallenges(showId, page: page)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> logout() {
    return _apiDataSource
        .apiLogout()
        .then(
          (value) => _localLogout(),
        )
        .then(
      (value) {
        Get.offAll(() => LoginPage(), binding: LoginBinding());
        return;
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
  Future<GetSocket> createQuizSocket(String challengeId) {
    return _apiDataSource
        .quizSocketUrl(challengeId)
        .then((socketUrl) => _apiDataSource.createSocket(socketUrl))
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> sendAnswer(
    GetSocket? socket,
    String questionId,
    String answerId,
  ) {
    return _apiDataSource.sendAnswer(socket, questionId, answerId);
  }

  @override
  Future<ClaimReward> claimReward() {
    return _apiDataSource
        .claimReward()
        .catchError((value) => _handleException(value));
  }

  //

  @override
  ValueListenable profileListenable() {
    return _localDataSource.profileListenable();
  }

  @override
  ValueListenable walletListenable() {
    return _localDataSource.walletListenable();
  }
}
