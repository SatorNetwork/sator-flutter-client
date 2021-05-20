import 'package:get_storage/get_storage.dart';
import 'package:satorio/data/datasource/local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const _token = 'token';

  GetStorage _storage = GetStorage('LocalDataSource');
}
