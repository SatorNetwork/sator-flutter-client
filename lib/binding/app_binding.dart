import 'package:get/get.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';
import 'package:satorio/data/datasource/impl/ApiDataSourceImpl.dart';
import 'package:satorio/data/datasource/impl/AuthDataSourceImpl.dart';
import 'package:satorio/data/datasource/impl/FirebaseDataSourceImpl.dart';
import 'package:satorio/data/datasource/impl/LocalDataSourceImpl.dart';
import 'package:satorio/data/datasource/impl/nats_data_source_impl.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/datasource/nats_data_source.dart';
import 'package:satorio/data/encrypt/ecrypt_manager.dart';
import 'package:satorio/data/encrypt/encrypt_manager_impl.dart';
import 'package:satorio/data/repository/satar_repository_impl.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EncryptManager>(EncryptManagerImpl(), permanent: true);

    Get.put<LocalDataSource>(LocalDataSourceImpl(), permanent: true);
    Get.put<AuthDataSource>(AuthDataSourceImpl(), permanent: true);
    Get.put<FirebaseDataSource>(FirebaseDataSourceImpl(), permanent: true);
    Get.put<ApiDataSource>(
      ApiDataSourceImpl(Get.find(), Get.find()),
      permanent: true,
    );
    Get.put<NatsDataSource>(NatsDataSourceImpl(), permanent: true);

    Get.put<SatorioRepository>(
      SatorioRepositoryImpl(Get.find(), Get.find(), Get.find(), Get.find()),
      permanent: true,
    );
  }
}
