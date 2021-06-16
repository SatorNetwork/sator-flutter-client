import 'package:get_storage/get_storage.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  static const _token = 'token';

  GetStorage _storage = GetStorage('AuthDataSource');

  @override
  void clearAll() {
    _storage.write(_token, '');
  }

  @override
  String? getAuthToken() {
    return _storage.read(_token);
  }

  @override
  void storeAuthToken(String token) {
    _storage.write(_token, token);
  }
}
