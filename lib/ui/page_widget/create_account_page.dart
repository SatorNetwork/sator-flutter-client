import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class CreateAccountPage extends GetView<CreateAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: SatorioColor.darkAccent),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 124 * coefficient),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('txt_create_account'.tr,
                          style: textTheme.headline1!.copyWith(
                              fontSize: 34.0 * coefficient,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 32 * coefficient,
                      ),
                      Obx(
                        () => InputTextField(
                          inputTitle: 'txt_email_address'.tr,
                          controller: controller.emailController,
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: false,
                          errorText: controller.validationRx.value['email'],
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => InputTextField(
                          inputTitle: 'txt_username'.tr,
                          controller: controller.usernameController,
                          hintText: 'txt_username_hint'.tr,
                          obscureText: false,
                          errorText: controller.validationRx.value['username'],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => InputTextField(
                          inputTitle: 'txt_password'.tr,
                          controller: controller.passwordController,
                          hintText: 'txt_password_hint'.tr,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: controller.passwordObscured.value,
                          errorText: controller.validationRx.value['password'],
                          icon: Icon(
                              controller.passwordObscured.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                              color: SatorioColor.darkAccent),
                          onPressedIcon: () {
                            controller.passwordObscured.toggle();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.termsOfServiceCheck.value,
                              onChanged: (value) {
                                controller.termsOfServiceCheck.toggle();
                              },
                            ),
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: 'txt_terms_of_service_description'.tr,
                                style: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: SatorioColor.textBlack),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'txt_terms_of_service'.tr,
                                    style: textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: SatorioColor.interactive),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.toTermsOfService();
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Obx(
                        () => ElevatedGradientButton(
                          text: 'txt_create_account'.tr,
                          isEnabled: controller.termsOfServiceCheck.value &&
                              !controller.isRequested.value,
                          onPressed: () {
                            controller.createAccount();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'txt_already_member'.tr,
                      style: textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: SatorioColor.textBlack),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'txt_sign_in'.tr,
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: SatorioColor.interactive),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.toSignIn();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
