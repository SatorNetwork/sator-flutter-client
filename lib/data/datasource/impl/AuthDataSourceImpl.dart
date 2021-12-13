import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  static const _token = 'token';
  static const _refreshToken = 'refreshToken';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> clearToken() async {
    await _secureStorage.write(key: _token, value: '');
  }

  @override
  Future<void> clearRefreshToken() async {
    await _secureStorage.write(key: _refreshToken, value: '');
  }

  @override
  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: _token);
  }

  @override
  Future<String?> getAuthRefreshToken() async {
    return await _secureStorage.read(key: _refreshToken);
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshToken, value: refreshToken);
  }

  @override
  Future<void> storeAuthToken(String token) async {
    await _secureStorage.write(key: _token, value: token);
  }
}
