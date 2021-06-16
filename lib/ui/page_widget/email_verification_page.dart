import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationPage extends GetView<CreateAccountController> {
  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 90;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: appBarHeight,
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
              (Get.mediaQuery.padding.top + appBarHeight),
          color: Colors.white,
          child: Padding(
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
                  "txt_verification_text".tr,
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
                  autoFocus: true,
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
                  controller: controller.verificationCodeController,
                  onCompleted: (v) {
                    print("Completed");
                    controller.verifyAccount();
                  },
                  onChanged: (value) {
                    controller.otp = value;
                    print(controller.otp);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}