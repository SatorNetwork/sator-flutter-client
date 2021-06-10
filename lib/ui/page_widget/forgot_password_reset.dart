import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/password_recovery_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class ForgotPasswordResetPage extends GetView<PasswordRecoveryController> {
  static const double _appBarHeight = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: _appBarHeight,
        iconTheme: IconThemeData(color: SatorioColor.darkAccent),
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: SatorioColor.darkAccent,
              size: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.mediaQuery.size.height -
              (Get.mediaQuery.padding.top + _appBarHeight),
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "txt_reset_password".tr,
                style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 34.0,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "txt_reset_password_text".tr,
                style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 36,
              ),
              Obx(
                () => InputTextField(
                  inputTitle: 'txt_new_password'.tr,
                  controller: controller.newPasswordController,
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
                height: 32,
              ),
              ElevatedGradientButton(
                text: 'txt_save'.tr,
                onPressed: () {
                  controller.resetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
