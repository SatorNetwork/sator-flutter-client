abstract class AuthDataSource {
  Future<String?> getAuthToken();

  Future<String?> getAuthRefreshToken();

  storeAuthToken(String token);

  storeRefreshToken(String refreshToken);

  clearToken();

  clearRefreshToken();
}
