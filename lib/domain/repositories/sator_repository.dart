import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/entities/transaction.dart';

abstract class SatorioRepository {
  Future<bool> isTokenValid();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> verifyAccount(String code);

  Future<bool> isVerified();

  Future<bool> resendCode();

  Future<bool> forgotPassword(String email);

  Future<bool> validateResetPasswordCode(String email, String code);

  Future<bool> resetPassword(String email, String code, String newPassword);

  Future<void> updateProfile();

  Future<void> updateWalletBalance();

  Future<void> updateWallets();

  Future<void> updateWalletDetail(String detailPath);

  Future<List<Transaction>> walletTransactions(String transactionsPath);

  Future<List<Show>> shows({int page});

  Future<List<Show>> showsFromCategory(String category);

  Future<ShowDetail> showDetail(String showId);

  Future<List<ShowSeason>> showSeasons(String showId);

  Future<List<ChallengeSimple>> showChallenges(String showId, {int page});

  Future<dynamic> loadShow(String showId);

  Future<dynamic> getShowEpisodeByQR(String qrCodeId);

  Future<Challenge> challenge(String challengeId);

  Future<void> logout();

  Future<GetSocket> createQuizSocket(String challengeId);

  Future<void> sendAnswer(
      GetSocket? socket, String questionId, String answerId);

  Future<ClaimReward> claimReward([String? claimRewardsPath]);

  //

  ValueListenable profileListenable();

  ValueListenable walletBalanceListenable();

  ValueListenable walletsListenable();

  ValueListenable walletDetailsListenable(List<String> ids);
}
