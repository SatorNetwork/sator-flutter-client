import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';

class NetflixDialog extends StatelessWidget {
  final String showTitle;

  const NetflixDialog(
    this.showTitle, {
    Key? key,
  }) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/show/watch.svg',
              height: 39 * coefficient,
              color: SatorioColor.interactive,
            ),
            SizedBox(
              height: 28 * coefficient,
            ),
            Text(
              'txt_where_can_watch'.tr,
              style: textTheme.headline5!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 20.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 18 * coefficient,
            ),
            Text(
              showTitle,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 17.0 * coefficient,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            Text(
              'txt_is_live_on'.tr,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 17.0 * coefficient,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 18 * coefficient,
            ),
            Image.asset(
              'images/tmp_netflix.png',
              height: 70 * coefficient,
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                String url = 'https://netflix.com';
                await canLaunch(url)
                    ? await launch(url)
                    : throw 'Could not launch $url';
              },
              child: Text(
                'netflix.com',
                textAlign: TextAlign.center,
                style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.interactive,
                  fontSize: 17.0 * coefficient,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 48 * coefficient,
            ),
            ElevatedGradientButton(
              text: 'txt_cool'.tr,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
