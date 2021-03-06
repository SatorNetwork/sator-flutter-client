import 'dart:io' show Platform;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class LoginPage extends GetView<LoginController> {
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
          height: Get.mediaQuery.size.height,
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 124 * coefficient),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'images/sator_logo_colored.svg',
                        height: 90 * coefficient,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        height: 68,
                      ),
                      Obx(
                        () => InputTextField(
                            inputTitle: 'txt_email_address'.tr,
                            controller: controller.emailController,
                            inputFormatters: [restrictSpace],
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: false,
                            autocorrect: false,
                            errorText: controller.validationRx.value['email']),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Obx(
                              () => InputTextField(
                                inputTitle: 'txt_password'.tr,
                                controller: controller.passwordController,
                                inputFormatters: [restrictSpace],
                                hintText: 'txt_password_hint'.tr,
                                obscureText: controller.passwordObscured.value,
                                keyboardType: TextInputType.emailAddress,
                                enableSuggestions: false,
                                autocorrect: false,
                                errorText:
                                    controller.validationRx.value['password'],
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
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                controller.toForgotPassword();
                              },
                              child: Text(
                                'txt_forgot_password'.tr,
                                style: textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: SatorioColor.interactive,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Obx(
                        () => ElevatedGradientButton(
                          text: 'txt_login'.tr,
                          isEnabled: controller.emailRx.value.isNotEmpty &&
                              controller.passwordRx.value.isNotEmpty,
                          isInProgress: controller.isRequested.value,
                          onPressed: () {
                            controller.signIn();
                          },
                        ),
                      ),
                      Obx(
                        () => controller.isBiometric.value && controller.isRefreshTokenExist.value
                            ? InkWell(
                                onTap: () =>
                                    {controller.checkingForBioMetrics()},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.fingerprint,
                                        size: 40,
                                        color: SatorioColor.interactive,
                                      ),
                                      Text(
                                        'txt_login_biometric'.tr,
                                        style: textTheme.bodyText1!.copyWith(
                                          color: SatorioColor.interactive,
                                          fontSize: 14 * coefficient,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 24.0,
                      left: 24.0,
                      bottom: isAndroid ? 24.0 : 50.0,
                      top: 24.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'txt_not_member'.tr,
                      style: textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: SatorioColor.textBlack),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'txt_create_account'.tr,
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: SatorioColor.interactive),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.toCreateAccount();
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
