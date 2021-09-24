import 'package:flutter/material.dart';
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
import 'package:satorio/util/extension.dart';

class CreateAccountController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final RxString emailRx = ''.obs;
  final RxString passwordRx = ''.obs;
  final RxString usernameRx = ''.obs;

  final RxBool termsOfUseCheck = false.obs;
  final RxBool passwordObscured = true.obs;
  final RxBool isRequested = false.obs;

  final SatorioRepository _satorioRepository = Get.find();

  late final Uri? deepLink;

  CreateAccountController() {
    CreateAccountArgument argument = Get.arguments as CreateAccountArgument;
    deepLink = argument.deepLink;
  }

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_emailListener);
    passwordController.addListener(_passwordListener);
    usernameController.addListener(_usernameListener);
  }

  @override
  void onClose() {
    emailController.removeListener(_emailListener);
    passwordController.removeListener(_passwordListener);
    usernameController.removeListener(_usernameListener);
    super.onClose();
  }

  void toTermsOfUse() {
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
            emailRx.value,
            passwordRx.value,
            usernameRx.value,
          ),
        )
        .then(
          (isSuccess) {
            if (isSuccess) {
              bool _isReferralCodeValid = deepLink != null &&
                  deepLink!.queryParameters['code'] != null &&
                  deepLink!.queryParameters['code']!.isNotEmpty;
              if (_isReferralCodeValid) {
                _satorioRepository
                    .confirmReferralCode(deepLink!.queryParameters['code']!);
              }
              Get.to(
                () => EmailVerificationPage(),
                binding: EmailVerificationBinding(),
                arguments: EmailVerificationArgument(emailRx.value),
              );
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: Text(
                      'txt_register_success'.tr.format([usernameRx.value])),
                ),
              );
            }
            isRequested.value = false;
          },
        )
        .catchError(
          (value) {
            isRequested.value = false;
            handleValidationException(value);
          },
        );
  }

  void _emailListener() {
    emailRx.value = emailController.text;
  }

  void _passwordListener() {
    passwordRx.value = passwordController.text;
  }

  void _usernameListener() {
    usernameRx.value = usernameController.text;
  }
}

class CreateAccountArgument {
  final Uri? deepLink;

  const CreateAccountArgument(this.deepLink);
}
