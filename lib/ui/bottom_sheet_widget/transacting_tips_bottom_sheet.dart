import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class TransactingTipsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'txt_transacting_tips'.tr,
            textAlign: TextAlign.center,
            style: textTheme.headline4!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 20.0 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          Text(
            'txt_transacting_tips_description'.tr,
            textAlign: TextAlign.center,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 15.0 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _tipWidget(),
              _tipWidget(),
              _tipWidget(),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            textAlign: TextAlign.start,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 15.0 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
            textAlign: TextAlign.start,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.brand,
              fontSize: 15.0 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'txt_more_info_transacting_tips'.tr,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 15.0 * coefficient,
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'txt_here'.tr,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.interactive,
                      fontSize: 15.0 * coefficient,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          ElevatedGradientButton(
            text: 'txt_i_understand'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget _tipWidget() {
    return ClipOval(
      child: Container(
        width: 50,
        height: 50,
        color: SatorioColor.darkAccent.withOpacity(0.2),
      ),
    );
  }
}
