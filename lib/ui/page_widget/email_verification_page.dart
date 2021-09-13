import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:satorio/controller/email_verification_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class EmailVerificationPage extends GetView<EmailVerificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: SatorioColor.darkAccent),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: Get.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
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
                  Row(
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: 'txt_verification_text_1'.tr,
                            style: TextStyle(
                                color: SatorioColor.textBlack,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: controller.email,
                                style: TextStyle(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: "txt_verification_text_2".tr,
                                style: TextStyle(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                    controller: controller.codeController,
                    onCompleted: (v) {
                      controller.verifyAccount();
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) => true,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () => controller.resendCode(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "txt_resend_code".tr,
                      style: TextStyle(
                          color: SatorioColor.interactive,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600),
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
