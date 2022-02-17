import 'package:satorio/data/model/activated_realm_model.dart';
import 'package:satorio/data/model/amount_currency_model.dart';
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
import 'package:satorio/data/model/qr_show_model.dart';
import 'package:satorio/data/model/referral_code_model.dart';
import 'package:satorio/data/model/review_model.dart';
import 'package:satorio/data/model/show_category_model.dart';
import 'package:satorio/data/model/show_detail_model.dart';
import 'package:satorio/data/model/show_episode_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/show_season_model.dart';
import 'package:satorio/data/model/transaction_model.dart';
import 'package:satorio/data/model/transfer_model.dart';
import 'package:satorio/data/model/wallet_detail_model.dart';
import 'package:satorio/data/model/wallet_model.dart';
import 'package:satorio/data/model/wallet_staking_model.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';

abstract class ApiDataSource {
  // region Firebase

  Future<void> init();

  // endregion

  // region Local Auth

  Future<bool> isTokenExist();

  Future<bool> isRefreshTokenExist();

  Future<void> removeAllTokens();

  Future<void> removeAuthToken();

  // endregion

  // region Auth

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> requestUpdateEmail(String email);

  Future<bool> updateUsername(String username);

  Future<bool> changePassword(String oldPassword, String newPassword);

  Future<bool> apiLogout();

  Future<bool> verifyAccount(String code);

  Future<bool> verifyUpdateEmail(String email, String code);

  Future<bool> isVerified();

  Future<bool> selectAvatar(String avatarPath);

  Future<bool> resendCode();

  Future<bool> refreshToken();

  Future<bool> signInViaRefreshToken();

  Future<bool> validateToken();

  Future<bool> forgotPassword(String email);

  Future<bool> validateResetPasswordCode(String email, String code);

  Future<bool> resetPassword(String email, String code, String newPassword);

  Future<bool> publicKey();

  // endregion

  // region KYC

  Future<String> kycToken();

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

  Future<double> possibleMultiplier(String walletId, double amount);

  Future<bool> stake(String walletId, double amount);

  Future<bool> unstake(String walletId);

  Future<WalletStakingModel> getStake(String walletId);

  // endregion

  // region Shows

  Future<List<ShowModel>> shows(bool? hasNfts, {int? page, int? itemsPerPage});

  Future<List<ShowCategoryModel>> showsCategoryList({
    int? page,
    int? itemsPerPage,
  });

  Future<List<ShowModel>> showsFromCategory(
    String category, {
    int? page,
    int? itemsPerPage,
  });

  Future<ShowDetailModel> showDetail(String showId);

  Future<List<ShowSeasonModel>> showSeasons(String showId);

  Future<ShowEpisodeModel> showEpisode(String showId, String episodeId);

  Future<List<ChallengeSimpleModel>> showChallenges(String showId, {int? page});

  Future<ShowModel> loadShow(String showId);

  Future<QrShowModel> getShowEpisodeByQR(String qrCodeId);

  Future<List<ReviewModel>> getReviews(String showId, String episodeId,
      {int? page, int? itemsPerPage});

  Future<List<ReviewModel>> getUserReviews({int? page, int? itemsPerPage});

  Future<List<ActivatedRealmModel>> getActivatedRealms({
    int? page,
    int? itemsPerPage,
  });

  Future<bool> clapShow(String showId);

  // endregion

  // region Challenges

  Future<ChallengeModel> challenge(String challengeId);

  Future<EpisodeActivationModel> isEpisodeActivated(String episodeId);

  Future<EpisodeActivationModel> paidUnlockEpisode(
    String episodeId,
    String paidOption,
  );

  Future<int> showEpisodeAttemptsLeft(String episodeId);

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

  Future<bool> sendReviewTip(String reviewId, double amount);

  Future<bool> rateReview(String reviewId, String ratingType);

  // endregion

  // region Quiz

  Future<NatsConfigModel> quizNats(String challengeId);

  // endregion

  // region Rewards

  Future<ClaimRewardModel> claimReward([String? claimRewardsPath]);

  // endregion

  // region Invitations

  Future<bool> sendInvite(String email);

  Future<ReferralCodeModel> getReferralCode();

  Future<bool> confirmReferralCode(String referralCode);

  // endregion

  // region NFT

  Future<List<NftItemModel>> allNfts({
    int? page,
    int? itemsPerPage,
  });

  Future<NftHomeModel> nftHome();

  Future<List<NftCategoryModel>> nftCategories();

  Future<List<NftItemModel>> nftItems(
    NftFilterType filterType,
    String id, {
    int? page,
    int? itemsPerPage,
  });

  Future<NftItemModel> nftItem(String nftItemId);

  Future<bool> buyNftItem(String nftItemId);

// endregion

}
