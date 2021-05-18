abstract class AuthDataSource {

  String getAuthToken();

  storeAuthToken(String token);

  clearAll();
}