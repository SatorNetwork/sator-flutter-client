import 'package:get/get.dart';
import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/challenge_model.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/claim_reward_model.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/show_detail_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/transaction_model.dart';
import 'package:satorio/data/model/wallet_detail_model.dart';
import 'package:satorio/data/model/wallet_model.dart';

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

  Future<List<TransactionModel>> walletTransactions(String transactionsPath);

  // endregion

  // region Shows

  Future<List<ShowModel>> shows({int? page});

  Future<List<ShowModel>> showsFromCategory(String category);

  Future<ShowDetailModel> showDetail(String showId);

  Future<List<ChallengeSimpleModel>> showChallenges(String showId, {int? page});

  Future<dynamic> loadShow(String showId);

  Future<dynamic> getShowEpisodeByQR(String qrCodeId);

  // endregion

  // region Challenges

  Future<ChallengeModel> challenge(String challengeId);

  // endregion

  // region Quiz

  Future<String> quizSocketUrl(String challengeId);

  // endregion

  // region Rewards

  Future<ClaimRewardModel> claimReward([String? claimRewardsPath]);

  // endregion

  // region Socket

  Future<GetSocket> createSocket(String url);

  Future<void> sendAnswer(
      GetSocket? socket, String questionId, String answerId);

// endregion

}
