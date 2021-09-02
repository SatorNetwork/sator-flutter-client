import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/ui/page_widget/web_page.dart';

class CreateAccountController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final RxBool termsOfServiceCheck = false.obs;
  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void toTermsOfService() {
    Get.to(
      () => WebPage(),
      binding: WebBinding(),
      arguments: WebArgument(
        'https://backoffice.dev.sator.io/legal/terms-of-use',
        'txt_terms_of_service'.tr,
      ),
    );
  }

  void toSignIn() {
    Get.off(() => LoginPage(),
        binding: LoginBinding(), arguments: LoginArgument(null));
  }

  void createAccount() {
    CreateAccountArgument argument = Get.arguments as CreateAccountArgument;

    _satorioRepository
        .signUp(
      emailController.text,
      passwordController.text,
      usernameController.text,
    )
        .then((isSuccess) {
      if (isSuccess) {
        bool _isValid = argument.deepLink != null &&
            argument.deepLink!.queryParameters['code'] != null &&
            argument.deepLink!.queryParameters['code']!.isNotEmpty;
        if (_isValid) {
          _satorioRepository
              .confirmReferralCode(argument.deepLink!.queryParameters['code']!);
        }
        Get.to(
          () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
        );
      }
    }).catchError((value) => handleValidationException(value));
  }
}

class CreateAccountArgument {
  final Uri? deepLink;

  const CreateAccountArgument(this.deepLink);
}
