import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';
import 'package:satorio/domain/entities/fcm_type.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';
import 'package:satorio/util/getx_extension.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.snackbarNotify(message, () => _fcmCallback(message));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _fcmCallback(message);
    });
  }

  void _fcmCallback(RemoteMessage message) {
    switch (message.data["type"]) {
      case FCMType.newShow:
        _fcmShow(message.data["show_id"]);
        break;
      case FCMType.newEpisode:
        _fcmEpisode(message);
        break;
    }
  }

  void _fcmShow(String showId) {
    final SatorioRepository _satorioRepository = Get.find();
    _satorioRepository.show(showId).then((show) {
      Get.to(
        () => ShowDetailWithEpisodesPage(),
        binding: ShowDetailWithEpisodesBinding(),
        arguments: ShowDetailWithEpisodesArgument(show),
      );
    });
  }

  void _fcmEpisode(RemoteMessage message) {
    final SatorioRepository _satorioRepository = Get.find();
    final String showId = message.data["show_id"];
    final String episodeId = message.data["episode_id"];
    final String seasonId = message.data["season_id"];

    _satorioRepository.showDetail(showId).then((showDetail) {
      _satorioRepository.showEpisode(showId, episodeId).then(
        (showEpisode) {
          _satorioRepository
              .seasonById(showId, seasonId)
              .then((ShowSeason showSeason) {
            Get.to(
              () => ShowEpisodesRealmPage(),
              binding: ShowEpisodesRealmBinding(),
              arguments: ShowEpisodeRealmArgument(
                  showDetail, showSeason, showEpisode, false),
            );
          });
        },
      );
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
    List idsFromFirebase =
        json.decode(_remoteConfig.getValue("in_app_ids").asString());

    return (idsFromFirebase).map((item) => item as String).toList();
  }

  @override
  Future logEvent(String name, Map<String, Object?>? parameters) async {
    return _firebaseAnalytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<String> solanaClusterUrl() async {
    return _remoteConfig.getString(
        isProduction ? 'solana_prod_cluster_url' : 'solana_dev_cluster_url');
  }

  @override
  Future<String> solanaClusterName() async {
    return _remoteConfig.getString(
        isProduction ? 'solana_prod_cluster_name' : 'solana_dev_cluster_name');
  }

  @override
  Future<String> solanaToken() async {
    return _remoteConfig
        .getString(isProduction ? 'sao_token_prod' : 'sao_token_dev');
  }

  @override
  Future<bool> isTokenLockEnabled() async {
    return _remoteConfig.getBool(
        isProduction ? 'enable_token_lock_prod' : 'enable_token_lock_dev');
  }

  @override
  Future<bool> isPaidUnlockEnabled() async {
    return _remoteConfig.getBool(
        isProduction ? 'enable_paid_unlock_prod' : 'enable_paid_unlock_dev');
  }

  @override
  Future<bool> isTipsEnabled() async {
    return _remoteConfig
        .getBool(isProduction ? 'enable_tips_prod' : 'enable_tips_dev');
  }
}
