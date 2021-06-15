import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:satorio/controller/password_recovery_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ForgotPasswordVerificationPage
    extends GetView<PasswordRecoveryController> {
  static const double _appBarHeight = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "txt_verification".tr,
                style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 34.0,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "txt_password_verification_text".tr,
                style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 36,
              ),
              PinCodeTextField(
                appContext: context,
                length: 5,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  disabledColor: SatorioColor.inputGrey,
                  inactiveFillColor: SatorioColor.inputGrey,
                  inactiveColor: SatorioColor.inputGrey,
                  activeColor: SatorioColor.inputGrey,
                  selectedColor: SatorioColor.inputGrey,
                  selectedFillColor: SatorioColor.inputGrey,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: SatorioColor.inputGrey,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: controller.codeController,
                onCompleted: (v) {
                  controller.validateCode();
                },
                onChanged: (value) {},
                beforeTextPaste: (text) => true,
              )
            ],
          ),
        ),
      ),
    );
  }
}