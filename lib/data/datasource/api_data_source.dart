import 'package:get/get.dart';
import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/challenge_model.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/claim_reward_model.dart';
import 'package:satorio/data/model/episode_activation_model.dart';
import 'package:satorio/data/model/payload/payload_question_model.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/qr_show_model.dart';
import 'package:satorio/data/model/referral_code_model.dart';
import 'package:satorio/data/model/review_model.dart';
import 'package:satorio/data/model/show_detail_model.dart';
import 'package:satorio/data/model/show_episode_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/show_season_model.dart';
import 'package:satorio/data/model/transaction_model.dart';
import 'package:satorio/data/model/transfer_model.dart';
import 'package:satorio/data/model/wallet_detail_model.dart';
import 'package:satorio/data/model/wallet_model.dart';
import 'package:satorio/data/model/wallet_stake_model.dart';

abstract class ApiDataSource {
  // region Local Auth

  Future<bool> isTokenExist();

  Future<void> authLogout();

  // endregion

  // region Auth

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> apiLogout();

  Future<bool> verifyAccount(String code);

  Future<bool> isVerified();

  Future<bool> selectAvatar(String avatarPath);

  Future<bool> resendCode();

  Future<bool> refreshToken();

  Future<bool> forgotPassword(String email);

  Future<bool> validateResetPasswordCode(String email, String code);

  Future<bool> resetPassword(String email, String code, String newPassword);

  // endregion

  // region Profile

  Future<ProfileModel> profile();

  // endregion

  // region Wallet

  Future<List<AmountCurrencyModel>> walletBalance();

  Future<List<WalletModel>> wallets();

  Future<WalletDetailModel> walletDetail(String detailPath);

  Future<List<TransactionModel>> walletTransactions(String transactionsPath,
      {DateTime? from, DateTime? to});

  Future<TransferModel> createTransfer(
    String fromWalletId,
    String recipientAddress,
    double amount,
  );

  Future<bool> confirmTransfer(String fromWalletId, String txHash);

  Future<bool> stake(String walletId, double amount);

  Future<bool> unstake(String walletId, double amount);

  Future<WalletStakeModel> getStake(String walletId);

  // endregion

  // region Shows

  Future<List<ShowModel>> shows({int? page, int? itemsPerPage});

  Future<List<ShowModel>> showsFromCategory(String category);

  Future<ShowDetailModel> showDetail(String showId);

  Future<List<ShowSeasonModel>> showSeasons(String showId);

  Future<ShowEpisodeModel> showEpisode(String showId, String episodeId);

  Future<List<ChallengeSimpleModel>> showChallenges(String showId, {int? page});

  Future<ShowModel> loadShow(String showId);

  Future<QrShowModel> getShowEpisodeByQR(String qrCodeId);

  Future<List<ReviewModel>> getReviews(String showId, String episodeId);
  
  Future<bool> clapShow(String showId);

  // endregion

  // region Challenges

  Future<ChallengeModel> challenge(String challengeId);

  Future<EpisodeActivationModel> isEpisodeActivated(String episodeId);

  Future<EpisodeActivationModel> paidUnlockEpisode(
    String episodeId,
    String paidOption,
  );

  Future<PayloadQuestionModel> showEpisodeQuizQuestion(String episodeId);

  Future<bool> showEpisodeQuizAnswer(String questionId, String answerId);

  Future<bool> rateEpisode(String showId, String episodeId, int rate);

  Future<bool> writeReview(
    String showId,
    String episodeId,
    int rating,
    String title,
    String review,
  );

  // endregion

  // region Quiz

  Future<String> quizSocketUrl(String challengeId);

  // endregion

  // region Rewards

  Future<ClaimRewardModel> claimReward([String? claimRewardsPath]);

  // endregion

  // region Invitations

  Future<bool> sendInvite(String email);

  Future<ReferralCodeModel> getReferralCode();

  Future<bool> confirmReferralCode(String referralCode);

  // endregion

  // region Socket

  Future<GetSocket> createSocket(String url);

  Future<void> sendAnswer(
      GetSocket? socket, String questionId, String answerId);

// endregion

}
