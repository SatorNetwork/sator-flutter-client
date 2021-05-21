import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';

abstract class SatorioRepository {
  Future<bool> isTokenValid();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<Profile> profile();

  Future<WalletBalance> walletBalance();
}
