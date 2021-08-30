import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/qr_show.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_stake.dart';

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

  Future<List<Wallet>> updateWallets();

  Future<void> updateWalletDetail(String detailPath);

  Future<void> updateWalletTransactions(String transactionsPath,
      {DateTime? from, DateTime? to});

  Future<Transfer> createTransfer(
    String fromWalletId,
    String recipientAddress,
    double amount,
  );

  Future<bool> confirmTransfer(String fromWalletId, String txHash);

  Future<bool> stake(String walletId, double amount);

  Future<bool> unstake(String walletId, double amount);

  Future<WalletStake> getStake(String walletId);

  Future<List<Show>> shows({int? page, int? itemsPerPage});

  Future<List<Show>> showsFromCategory(String category);

  Future<ShowDetail> showDetail(String showId);

  Future<List<ShowSeason>> showSeasons(String showId);

  Future<List<ChallengeSimple>> showChallenges(String showId, {int page});

  Future<Show> loadShow(String showId);

  Future<QrShow> getShowEpisodeByQR(String qrCodeId);

  Future<Challenge> challenge(String challengeId);

  Future<EpisodeActivation> isEpisodeActivated(String episodeId);

  Future<EpisodeActivation> paidUnlockEpisode(
    String episodeId,
    String paidOption,
  );

  Future<PayloadQuestion> showEpisodeQuizQuestion(String episodeId);

  Future<bool> showEpisodeQuizAnswer(String questionId, String answerId);

  Future<bool> rateEpisode(String showId, String episodeId, int rate);

  Future<void> logout();

  Future<GetSocket> createQuizSocket(String challengeId);

  Future<void> sendAnswer(
      GetSocket? socket, String questionId, String answerId);

  Future<ClaimReward> claimReward([String? claimRewardsPath]);

  Future<bool> sendInvite(String email);

  //

  ValueListenable profileListenable();

  ValueListenable walletBalanceListenable();

  ValueListenable walletsListenable();

  ValueListenable walletDetailsListenable(List<String>? ids);

  ValueListenable transactionsListenable();
}
