import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class SendInviteDialog extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'txt_enter_invite_email'.tr,
              textAlign: TextAlign.center,
              style: textTheme.headline1!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 21.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 24 * coefficient,
            ),
            TextFormField(
              controller: _amountController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.emailAddress,
              style: textTheme.bodyText1!.copyWith(
                fontSize: 17 * coefficient,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: SatorioColor.textBlack),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: SatorioColor.textBlack),
                ),
              ),
            ),
            SizedBox(
              height: 32 * coefficient,
            ),
            ElevatedGradientButton(
              text: 'txt_send_invite'.tr,
              onPressed: () {
                String text = _amountController.text;
                if (text.isEmail) {
                  SatorioRepository satorioRepository = Get.find();
                  satorioRepository.sendInvite(text).then(
                    (bool result) {
                      if (result) {
                        Get.back();
                        Get.dialog(
                          DefaultDialog(
                            'txt_success'.tr,
                            'txt_invitation_sent'.tr,
                            'txt_ok'.tr,
                            icon: Icons.check_rounded,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
