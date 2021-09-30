import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:satorio/controller/email_verification_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';
import 'package:satorio/util/extension.dart';

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
                        fontSize: 34 * coefficient,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _descriptionWidget(),
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
                      fieldHeight: 50 * coefficient,
                      fieldWidth: 50 * coefficient,
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
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Obx(
                    () => controller.delayRx.value != 0
                        ? Text(
                            '${controller.delayRx.value ~/ 60}:${controller.delayRx.value.remainder(60).toInt().toString().padLeft(2, '0')}',
                            style: TextStyle(
                                color: SatorioColor.textBlack,
                                fontSize: 17 * coefficient,
                                fontWeight: FontWeight.w600),
                          )
                        : InkWell(
                            onTap: () => controller.resendCode(),
                            child: Text(
                              'txt_resend_code'.tr,
                              style: TextStyle(
                                  color: SatorioColor.interactive,
                                  fontSize: 17 * coefficient,
                                  fontWeight: FontWeight.w600),
                            ),
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

  Widget _descriptionWidget() {
    final String email = controller.email;
    final String textFull = 'txt_verification_text'.tr.format([email]);

    final int start = textFull.indexOf(email);
    final int end = start + email.length;

    return Text.rich(
      TextSpan(
        text: textFull.substring(0, start),
        style: textTheme.bodyText2!.copyWith(
          color: SatorioColor.textBlack,
          fontSize: 15 * coefficient,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: textFull.substring(start, end),
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 15 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: textFull.substring(end),
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 15 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
