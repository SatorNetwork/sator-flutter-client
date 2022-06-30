abstract class FirebaseDataSource {
  Future<void> initRemoteConfig();

  Future<String> firebaseChatChild();

  Future<String> apiBaseUrl();

  Future<String> nftsApiUrl();

  Future<String> nftsMarketplaceUrl();

  Future<String> firebaseUrl();

  Future<String> claimRewardText();

  Future<String> quizHeadTitleText();

  Future<String> quizHeadMessageText();

  Future<String?> fcmToken();

  Future<void> initNotifications();

  Future<int> appVersion();

  Future inAppProductsIds();

  Future logEvent(String name, Map<String, Object?>? parameters);

  Future<String> solanaToken();

  Future<String> solanaClusterUrl();

  Future<String> solanaClusterName();

  Future<bool> isTokenLockEnabled();

  Future<bool> isPaidUnlockEnabled();

  Future<bool> isTipsEnabled();

  Future<bool> isBottomSheetPtsEnabled();

  Future<bool> isWinnerScoresEnabled();

  Future<bool> isHomeBalanceEnabled();

  Future<bool> isRealmEarnedSaoEnabled();
}
