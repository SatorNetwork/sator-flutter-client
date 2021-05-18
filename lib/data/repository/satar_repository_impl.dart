import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class SatorioRepositoryImpl implements SatorioRepository {
  final ApiDataSource _apiDataSource;
  final LocalDataSource _localDataSource;

  SatorioRepositoryImpl(this._apiDataSource, this._localDataSource);

  @override
  Future<bool> signIn(String email, String password) {
    return _apiDataSource.signIn(email, password);
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _apiDataSource.signUp(email, password, username);
  }
}
