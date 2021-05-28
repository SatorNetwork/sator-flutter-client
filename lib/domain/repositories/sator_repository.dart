import 'package:satorio/domain/entities/challenge_detail.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';

abstract class SatorioRepository {
  Future<bool> isTokenValid();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<Profile> profile();

  Future<WalletBalance> walletBalance();

  Future<List<Show>> shows({int page});

  Future<List<ChallengeSimple>> showChallenges({int page, String id});

  Future<ChallengeDetail> challenge(String challengeId);

  Future<void> logout();
}
