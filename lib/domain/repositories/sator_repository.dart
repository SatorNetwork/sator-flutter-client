import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/selected_show_challenges.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';

abstract class SatorioRepository {
  Future<bool> isTokenValid();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<Profile> profile();

  Future<WalletBalance> walletBalance();

  Future<List<Show>> shows({int page});

  Future<List<SelectedShowChallenges>> selectedShowChallenges({int page, String id});

  Future<void> logout();
}
