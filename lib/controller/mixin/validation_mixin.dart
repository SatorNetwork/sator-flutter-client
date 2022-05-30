import 'package:get/get.dart';
import 'package:satorio/data/datasource/exception/api_validation_exception.dart';

mixin ValidationMixin on GetxController {
  final Rx<Map<String, String?>> validationRx = Rx({});

  Future<Null> handleValidationException(Exception exception) async {
    if (exception is ApiValidationException) {
      validationRx.value = exception.validationMap;
    }
  }
}
