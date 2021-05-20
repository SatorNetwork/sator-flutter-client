abstract class ApiDataSource {
  Future<bool> isTokenExist();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> refreshToken();
}
