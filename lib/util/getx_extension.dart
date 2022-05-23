import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';

extension SatorGetInterface on GetInterface {
  SnackbarController snackbarMessage(
    String title,
    String message, {
    SnackbarStatusCallback? snackbarStatus,
  }) {
    return Get.snackbar(title, message,
        backgroundColor: SatorioColor.carnation_pink.withOpacity(0.8),
        colorText: SatorioColor.darkAccent,
        duration: Duration(seconds: 4),
        snackbarStatus: snackbarStatus);
  }

  SnackbarController snackbarWithButton(
    String title,
    String message,
  ) {
    return Get.snackbar(
      title,
      message,
    );
  }
}
