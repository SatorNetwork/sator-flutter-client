import 'package:get_storage/get_storage.dart';
import 'package:satorio/data/datasource/local_data_source.dart';

class LocalDataSourceImpl extends LocalDataSource {
  static const _token = 'token';

  GetStorage _storage = GetStorage();

  @override
  Future<void> clearAll() {
    return _storage.erase();
  }

  @override
  Future<String> getAuthToken() async {
    return _storage.read(_token);
  }

  @override
  Future<void> storeAuthToken(String token) async {
    return _storage.write(_token, token);
  }
}
