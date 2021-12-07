abstract class FirebaseDataSource {
  Future<void> initRemoteConfig();

  Future<String> firebaseChatChild();

  Future<String> apiBaseUrl();

  Future<String> firebaseUrl();
}
