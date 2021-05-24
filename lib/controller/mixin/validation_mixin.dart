import 'package:get/get.dart';
import 'package:satorio/data/datasource/exception/api_validation_exception.dart';

mixin ValidationMixin {
  final Rx<Map<String, String>> validationRx = Rx({});

  void handleValidationException(Exception exception) {
    if (exception is ApiValidationException) {
      validationRx.value = exception.validationMap;
      exception.validationMap.forEach((key, value) {
        print('$key = $value');
      });
    }
  }
}
