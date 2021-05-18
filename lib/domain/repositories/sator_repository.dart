abstract class SatorioRepository {
  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);
}
