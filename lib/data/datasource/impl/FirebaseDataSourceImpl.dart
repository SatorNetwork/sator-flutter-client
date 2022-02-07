import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  RemoteConfig _remoteConfig = RemoteConfig.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final bool isProduction = false;

  Future<void> initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 1),
      minimumFetchInterval: Duration(seconds: 10),
    ));

    await _remoteConfig.fetchAndActivate();
  }

  Future<void> initNotifications() async {
    if (GetPlatform.isIOS) {
      _firebaseMessaging.requestPermission();
    }

    String? token = await fcmToken();
    print("FirebaseMessaging token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification}");
    });
  }

  Future<String> firebaseChatChild() async {
    return _remoteConfig.getString(
        isProduction ? 'firebase_prod_chat_child' : 'firebase_test_chat_child');
  }

  Future<String> apiBaseUrl() async {
    return _remoteConfig
        .getString(isProduction ? 'api_base_prod_url' : 'api_base_dev_url');
  }

  Future<String> nftsApiUrl() async {
    return _remoteConfig
        .getString(isProduction ? 'nfts_api_dev_url' : 'nfts_api_dev_url');
  }

  Future<String> firebaseUrl() async {
    return _remoteConfig
        .getString(isProduction ? 'firebase_url' : 'firebase_url');
  }

  Future<String> claimRewardText() async {
    return _remoteConfig.getString('claim_reward_text');
  }

  Future<String?> fcmToken() async {
    return _firebaseMessaging.getToken();
  }

  Future<int> appVersion() async {
    return _remoteConfig.getInt('min_app_version');
  }
}
