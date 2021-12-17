import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  RemoteConfig _remoteConfig = RemoteConfig.instance;
  final bool isProduction = false;

  Future<void> initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 1),
      minimumFetchInterval: Duration(seconds: 10),
    ));

    await _remoteConfig.fetchAndActivate();
  }
  
  Future<String> firebaseChatChild() async {
    return _remoteConfig.getString(isProduction ? 'firebase_prod_chat_child' : 'firebase_test_chat_child');
  }

  Future<String> apiBaseUrl() async {
    return _remoteConfig.getString(isProduction ? 'api_base_prod_url' : 'api_base_dev_url');
  }

  Future<String> firebaseUrl() async {
    return _remoteConfig.getString(isProduction ? 'firebase_url' : 'firebase_url');
  }

  Future<String> claimRewardText() async {
    return _remoteConfig.getString('claim_reward_text');
  }
}
