import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ClaimRewardsBottomSheet extends StatelessWidget with BackToMainMixin {
  const ClaimRewardsBottomSheet(this.data);

  final ClaimReward data;

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
                  if (Get.isRegistered<MainController>()) {
                    if (Get.currentRoute != '/() => MainPage') {
                      MainController mainController = Get.find();
                      mainController.selectedBottomTabIndex.value = MainController.TabWallet;
                    }
                    backToMain();
                  } else {
                    Get.back();
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => _launchURL(data.transactionUrl),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: Colors.black.withOpacity(0.11), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'txt_solana_link'.tr,
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.darkAccent,
                          fontSize: 16.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Icon(
                        Icons.open_in_new_rounded,
                        color: SatorioColor.darkAccent,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
