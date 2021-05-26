import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: SatorioColor.darkAccent),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.mediaQuery.size.height -
              (Get.mediaQuery.padding.top + kToolbarHeight),
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/logo.png',
                        height: 90,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        height: 68,
                      ),
                      Obx(
                        () => InputTextField(
                            inputTitle: 'txt_email_address'.tr,
                            controller: controller.emailController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            errorText: controller.validationRx.value['email']),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => InputTextField(
                          inputTitle: 'txt_password'.tr,
                          controller: controller.passwordController,
                          hintText: 'txt_password_hint'.tr,
                          obscureText: controller.passwordObscured.value,
                          keyboardType: TextInputType.emailAddress,
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
                        height: 32,
                      ),
                      ElevatedGradientButton(
                        text: 'txt_login'.tr,
                        onPressed: () {
                          controller.signIn();
                        },
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
                        text: 'txt_not_member'.tr,
                        style: TextStyle(
                            color: SatorioColor.textBlack,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'txt_create_account'.tr,
                            style: TextStyle(
                                color: SatorioColor.interactive,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.toCreateAccount();
                              },
                          ),
                        ]),
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
