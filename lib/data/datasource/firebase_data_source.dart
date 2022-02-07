abstract class FirebaseDataSource {
  Future<void> initRemoteConfig();

  Future<String> firebaseChatChild();

  Future<String> apiBaseUrl();

  Future<String> nftsApiUrl();

  Future<String> firebaseUrl();

  Future<String> claimRewardText();

  Future<String?> fcmToken();

  Future<void> initNotifications();

  Future<int> appVersion();
}
