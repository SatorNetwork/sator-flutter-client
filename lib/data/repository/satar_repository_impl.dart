import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class SatorRepositoryImpl implements SatorRepositoryInterface {
  final ApiDataSource _apiDataSource;
  final LocalDataSource _localDataSource;

  SatorRepositoryImpl(this._apiDataSource, this._localDataSource);

  void fun() {
    print('${_apiDataSource.runtimeType}');
    print('${_localDataSource.runtimeType}');
  }
}
