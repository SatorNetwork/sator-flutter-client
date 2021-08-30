import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ClaimRewardsBottomSheet extends StatelessWidget with BackToMainMixin {
  const ClaimRewardsBottomSheet(this.data, this.onAwesomePressed);

  final ClaimReward data;
  final VoidCallback? onAwesomePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 60 * coefficient,
                color: SatorioColor.interactive,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'txt_congrats'.tr,
                style: textTheme.headline1!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 34.0 * coefficient,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'txt_congrats_msg'.tr,
                textAlign: TextAlign.center,
                style: textTheme.bodyText1!.copyWith(
                    color: SatorioColor.textBlack, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                data.amount,
                style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Column(
            children: [
              ElevatedGradientButton(
                text: 'txt_awesome'.tr,
                onPressed: () {
                  Get.back();
                  if (onAwesomePressed != null) {
                    onAwesomePressed!();
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              BorderedButton(
                text: 'txt_solana_link'.tr,
                borderColor: Colors.black.withOpacity(0.11),
                icon: Icon(
                  Icons.open_in_new_rounded,
                  color: SatorioColor.darkAccent,
                ),
                onPressed: () {
                  Get.back();
                  _launchURL(data.transactionUrl);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
