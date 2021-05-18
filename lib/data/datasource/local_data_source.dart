abstract class LocalDataSource {
  Future<String> getAuthToken();

  Future<void> storeAuthToken(String token);

  Future<void> clearAll();
}
