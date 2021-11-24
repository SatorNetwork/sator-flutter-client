abstract class AuthDataSource {
  Future<String?> getAuthToken();

  storeAuthToken(String token);

  storeRefreshToken(String password);

  clearToken();

  clearRefreshToken();
}
