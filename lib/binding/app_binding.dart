import 'package:get/get.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/impl/ApiDataSourceImpl.dart';
import 'package:satorio/data/datasource/impl/LocalDataSourceImpl.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/repository/satar_repository_impl.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocalDataSource>(LocalDataSourceImpl());
    Get.put<ApiDataSource>(ApiDataSourceImpl());

    Get.put<SatorRepositoryInterface>(
        SatorRepositoryImpl(Get.find(), Get.find()));
  }
}
