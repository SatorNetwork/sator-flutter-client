import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final bool isProduction = false;

  @override
  Future<void> initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 2),
      minimumFetchInterval: Duration(seconds: 10),
    ));

    await _remoteConfig.fetchAndActivate();
  }

  @override
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

  @override
  Future<String> firebaseChatChild() async {
    return _remoteConfig.getString(
        isProduction ? 'firebase_prod_chat_child' : 'firebase_test_chat_child');
  }

  @override
  Future<String> apiBaseUrl() async {
    return _remoteConfig
        .getString(isProduction ? 'api_base_prod_url' : 'api_base_dev_url');
  }

  @override
  Future<String> nftsApiUrl() async {
    return _remoteConfig
        .getString(isProduction ? 'nfts_api_prod_url' : 'nfts_api_dev_url');
  }

  @override
  Future<String> nftsMarketplaceUrl() async {
    return _remoteConfig.getString(
        isProduction ? 'nft_prod_marketplace' : 'nft_dev_marketplace');
  }

  @override
  Future<String> firebaseUrl() async {
    return _remoteConfig
        .getString(isProduction ? 'firebase_url' : 'firebase_url');
  }

  @override
  Future<String> claimRewardText() async {
    return _remoteConfig.getString('claim_reward_text');
  }

  @override
  Future<String> quizHeadTitleText() async {
    return _remoteConfig.getString('quiz_head_title_text');
  }

  Future<String> quizHeadMessageText() async {
    return _remoteConfig.getString('quiz_head_message_text');
  }

  Future<String?> fcmToken() async {
    return _firebaseMessaging.getToken();
  }

  @override
  Future<int> appVersion() async {
    return _remoteConfig.getInt('min_app_version');
  }

  @override
  Future<List<String>> inAppProductsIds() async {
    List idsFromFirebase = json.decode(_remoteConfig.getValue("in_app_ids").asString());

    return (idsFromFirebase).map((item) => item as String).toList();
  }
}
