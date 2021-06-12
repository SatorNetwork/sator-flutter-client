import 'package:get/get.dart';
import 'package:satorio/data/model/amount_currency_model.dart';
import 'package:satorio/data/model/challenge_model.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/claim_reward_model.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/show_model.dart';

abstract class ApiDataSource {
  Future<bool> isTokenExist();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> refreshToken();

  Future<bool> forgotPassword(String email);

  Future<bool> validateResetPasswordCode(String email, String code);

  Future<bool> resetPassword(String email, String code, String newPassword);

  Future<ProfileModel> profile();

  Future<List<AmountCurrencyModel>> wallet();

  Future<List<ShowModel>> shows({int? page});

  Future<List<ChallengeSimpleModel>> showChallenges(String showId, {int? page});

  Future<ChallengeModel> challenge(String challengeId);

  Future<void> logout();

  Future<String> socketUrl(String challengeId);

  Future<GetSocket> createSocket(String url);

  Future<void> sendAnswer(
      GetSocket? socket, String questionId, String answerId);

  Future<ClaimRewardModel> claimReward();
}
