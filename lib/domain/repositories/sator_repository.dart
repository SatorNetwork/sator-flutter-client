import 'package:dart_nats/dart_nats.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
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
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';

abstract class SatorioRepository {
  final RxBool isInited = false.obs;

  Future<void> initRemoteConfig();

  Future<String> firebaseChatChild();

  Future<String> firebaseUrl();

  Future<String> claimRewardsText();

  Future<int> appVersion();

  Future<String> nftsMarketplaceUrl();

  Future<void> clearDBandAccessToken();

  Future<void> clearDBandAllTokens();

  Future<void> clearAllTokens();

  Future<void> removeTokenIsBiometricEnabled();

  Future<bool> isTokenValid();

  Future<bool> isRefreshTokenExist();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> requestUpdateEmail(String email);

  Future<bool> updateUsername(String username);

  Future<bool> changePassword(String oldPassword, String newPassword);

  Future<bool> verifyAccount(String code);

  Future<bool> verifyUpdateEmail(String email, String code);

  Future<bool> isVerified();

  Future<bool> validateToken();

  Future<bool> signInViaRefreshToken();

  Future<bool> isOnBoarded();

  Future<void> markOnBoarded();

  Future<bool> isBiometricEnabled();

  Future<void> markIsBiometricEnabled(bool isBiometricEnabled);

  Future<void> markIsBiometricUserDisabled();

  Future<bool?> isBiometricUserDisabled();

  Future<bool> selectAvatar(String avatarPath);

  Future<bool> resendCode();

  Future<bool> forgotPassword(String email);

  Future<bool> validateResetPasswordCode(String email, String code);

  Future<bool> resetPassword(String email, String code, String newPassword);

  Future<void> updateProfile();

  Future<void> updateWalletBalance();

  Future<List<Wallet>> updateWallets();

  Future<void> updateWalletDetail(String detailPath);

  Future<void> updateWalletTransactions(
    String transactionsPath, {
    DateTime? from,
    DateTime? to,
  });

  Future<Transfer> createTransfer(
    String fromWalletId,
    String recipientAddress,
    double amount,
  );

  Future<bool> confirmTransfer(String fromWalletId, String txHash);

  Future<double> possibleMultiplier(String walletId, double amount);

  Future<bool> stake(String walletId, double amount);

  Future<bool> unstake(String walletId);

  Future<WalletStaking> getStake(String walletId);

  Future<List<StakeLevel>> stakeLevels();

  Future<List<Show>> shows(bool? hasNfts, {int? page, int? itemsPerPage});

  Future<List<ShowCategory>> showsCategoryList({
    int? page,
    int? itemsPerPage,
  });

  Future<List<Show>> showsFromCategory(
    String category, {
    int? page,
    int? itemsPerPage,
  });

  Future<ShowDetail> showDetail(String showId);

  Future<List<ShowSeason>> showSeasons(String showId);

  Future<ShowEpisode> showEpisode(String showId, String episodeId);

  Future<Show> loadShow(String showId);

  Future<QrShow> getShowEpisodeByQR(String qrCodeId);

  Future<bool> clapShow(String showId);

  Future<Challenge> challenge(String challengeId);

  Future<List<ChallengeSimple>> challenges({
    int? page,
    int? itemsPerPage,
  });

  Future<EpisodeActivation> isEpisodeActivated(String episodeId);

  Future<EpisodeActivation> paidUnlockEpisode(
    String episodeId,
    String paidOption,
  );

  Future<int> showEpisodeAttemptsLeft(String episodeId);

  Future<PayloadQuestion> showEpisodeQuizQuestion(String episodeId);

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

  Future<void> logout();

  Future<NatsConfig> quizNats(String challengeId);

  Future<Subscription> subscribeNats(String url, String subject);

  Future<void> unsubscribeNats(Subscription subscription);

  Future<void> sendAnswer(
    String subject,
    String serverPublicKey,
    String questionId,
    String answerId,
  );

  Future<void> sendPing(
    String subject,
    String serverPublicKey,
  );

  Future<String> decryptData(String data);

  Future<ClaimReward> claimReward([String? claimRewardsPath]);

  Future<bool> sendInvite(String email);

  Future<ReferralCode> getReferralCode();

  Future<bool> confirmReferralCode(String referralCode);

  Future<List<Review>> getReviews(String showId, String episodeId,
      {int? page, int? itemsPerPage});

  Future<List<Review>> getUserReviews({int? page, int? itemsPerPage});

  Future<List<ActivatedRealm>> getActivatedRealms({
    int? page,
    int? itemsPerPage,
  });

  Future<List<NftItem>> allNfts({
    int? page,
    int? itemsPerPage,
  });

  Future<NftHome> nftHome();

  Future<List<NftCategory>> nftCategories();

  Future<List<NftItem>> nftItems(
    NftFilterType filterType,
    String objectId, {
    int? page,
    int? itemsPerPage,
  });

  Future<NftItem> nftItem(String nftItemId);

  Future<bool> buyNftItem(String nftItemId);

  //

  ValueListenable profileListenable();

  ValueListenable walletBalanceListenable();

  ValueListenable walletsListenable();

  ValueListenable walletDetailsListenable(List<String>? ids);

  ValueListenable transactionsListenable();

  //TODO: move to region
  Future<List<NftItem>> nftsFiltered({
    int? page,
    int? itemsPerPage,
    List<String>? showIds,
    String? orderType,
    String? owner,
  });

  Future<NftItem> nft(String mintAddress);

  Future<List<PuzzleUnlockOption>> puzzleOptions();

  Future<PuzzleGame?> puzzle(String episodeId);

  Future<PuzzleGame> unlockPuzzle(
    String puzzleGameId,
    String unlockOption,
  );

  Future<PuzzleGame> startPuzzle(String puzzleGameId);

  Future<PuzzleGame> finishPuzzle(
    String puzzleGameId,
    int result,
    int stepsTaken,
  );
}
