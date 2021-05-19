import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/ElevatedGradientButton.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class CreateAccountPage extends GetView<CreateAccountController> {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'txt_create_account'.tr,
                        style: TextStyle(
                            color: SatorioColor.textBlack,
                            fontSize: 34.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputTextField(
                        inputTitle: 'txt_email_address'.tr,
                        controller: controller.emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InputTextField(
                        inputTitle: 'txt_username'.tr,
                        controller: controller.usernameController,
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Obx(() => InputTextField(
                            inputTitle: 'txt_password'.tr,
                            controller: controller.passwordController,
                            hintText: 'txt_password_hint'.tr,
                            obscureText: controller.passwordObscured.value,
                            icon: Icon(
                                controller.passwordObscured.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye_outlined,
                                color: SatorioColor.darkAccent),
                            onPressedIcon: () {
                              controller.passwordObscured.toggle();
                            },
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Obx(() => Checkbox(
                                value: controller.termsOfServiceCheck.value,
                                onChanged: (value) {
                                  controller.termsOfServiceCheck.toggle();
                                },
                              )),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: 'txt_terms_of_service_description'.tr,
                                  style: TextStyle(
                                      color: SatorioColor.textBlack,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'txt_terms_of_service'.tr,
                                      style: TextStyle(
                                          color: SatorioColor.interactive,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.toTermsOfService();
                                        },
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      ElevatedGradientButton(
                        text: 'txt_create_account'.tr,
                        onPressed: () {
                          controller.createAccount();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'txt_already_member'.tr,
                        style: TextStyle(
                            color: SatorioColor.textBlack,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'txt_sign_in'.tr,
                            style: TextStyle(
                                color: SatorioColor.interactive,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.toSignIn();
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
