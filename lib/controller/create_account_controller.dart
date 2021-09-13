import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/email_verification_controller.dart';
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
  final RxBool isRequested = false.obs;

  final SatorioRepository _satorioRepository = Get.find();

  late final Uri? deepLink;

  CreateAccountController() {
    CreateAccountArgument argument = Get.arguments as CreateAccountArgument;
    deepLink = argument.deepLink;
  }

  void toTermsOfService() {
    Get.to(
      () => WebPage(),
      binding: WebBinding(),
      arguments: WebArgument(
        'https://backoffice.dev.sator.io/legal/terms-of-use',
      ),
    );
  }

  void toSignIn() {
    Get.off(
      () => LoginPage(),
      binding: LoginBinding(),
      arguments: LoginArgument(null),
    );
  }

  void createAccount() {
    Future.value(true)
        .then((value) {
          isRequested.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.signUp(
            emailController.text,
            passwordController.text,
            usernameController.text,
          ),
        )
        .then(
          (isSuccess) {
            if (isSuccess) {
              bool _isValid = deepLink != null &&
                  deepLink!.queryParameters['code'] != null &&
                  deepLink!.queryParameters['code']!.isNotEmpty;
              if (_isValid) {
                _satorioRepository.confirmReferralCode(
                    deepLink!.queryParameters['code']!);
              }
              Get.to(
                () => EmailVerificationPage(),
                binding: EmailVerificationBinding(),
                arguments: EmailVerificationArgument(emailController.text)
              );
            }
            isRequested.value = false;
          },
        )
        .catchError(
          (value) {
            handleValidationException(value);
            isRequested.value = false;
          },
        );
  }
}

class CreateAccountArgument {
  final Uri? deepLink;

  const CreateAccountArgument(this.deepLink);
}
