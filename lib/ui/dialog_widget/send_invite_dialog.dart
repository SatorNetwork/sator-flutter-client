import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:share_plus/share_plus.dart';

class SendInviteDialog extends StatelessWidget {
  final String referralLink;

  const SendInviteDialog(this.referralLink);

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
              'Referral link',
              textAlign: TextAlign.center,
              style: textTheme.headline6!.copyWith(
                color: SatorioColor.bright_grey,
                fontSize: 15 * coefficient,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            Text(
              referralLink,
              textAlign: TextAlign.center,
              style: textTheme.headline6!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 15 * coefficient,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            InkWell(
              onTap: () {
                _copyLink();
              },
              child: Padding(
                padding: EdgeInsets.all(8 * coefficient),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.file_copy_rounded,
                      size: 16 * coefficient,
                      color: SatorioColor.interactive,
                    ),
                    SizedBox(
                      width: 9 * coefficient,
                    ),
                    Text(
                      'Copy link',
                      textAlign: TextAlign.center,
                      style: textTheme.headline6!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32 * coefficient,
            ),
            ElevatedGradientButton(
              text: 'Share link',
              onPressed: () {
                _shareLink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareLink() async {
    if (referralLink == '') return;

    Share.share(referralLink);
  }

  void _copyLink() {
    Clipboard.setData(
      ClipboardData(
        text: referralLink,
      ),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('txt_copied_clipboard'.tr),
      ),
    );
  }
}
