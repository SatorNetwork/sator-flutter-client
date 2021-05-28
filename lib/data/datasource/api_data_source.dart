import 'package:satorio/data/model/challenge_simple_model.dart';
import 'package:satorio/data/model/challenge_detail_model.dart';
import 'package:satorio/data/model/profile_model.dart';
import 'package:satorio/data/model/show_model.dart';
import 'package:satorio/data/model/wallet_balance_model.dart';

abstract class ApiDataSource {
  Future<bool> isTokenExist();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> refreshToken();

  Future<ProfileModel> profile();

  Future<WalletBalanceModel> walletBalance();

  Future<List<ShowModel>> shows({int page});

  Future<List<ChallengeSimpleModel>> showChallenges({int page, String id});

  Future<ChallengeDetailModel> challenge(String challengeId);

  Future<void> logout();
}
