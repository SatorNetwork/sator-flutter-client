import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/extension.dart';

class SuccessNftBoughtBottomSheet extends StatelessWidget with BackToMainMixin {
  final String nftItemName;

  const SuccessNftBoughtBottomSheet(
    this.nftItemName, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36 * coefficient,
            height: 36 * coefficient,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SatorioColor.interactive,
            ),
            child: Center(
              child: Icon(
                Icons.check_rounded,
                size: 24 * coefficient,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 24 * coefficient,
          ),
          Text(
            'txt_congrats'.tr,
            style: textTheme.headline1!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 34.0 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          _descriptionWidget(),
          SizedBox(
            height: 32 * coefficient,
          ),
          ElevatedGradientButton(
            text: 'txt_awesome'.tr,
            onPressed: () {
              Get.back(closeOverlays: true);
            },
          ),
          SizedBox(
            height: 12 * coefficient,
          ),
          BorderedButton(
            text: 'txt_to_my_nfts'.tr,
            textColor: SatorioColor.interactive,
            borderColor: SatorioColor.interactive,
            borderWidth: 2,
            onPressed: () => _toMyNtfs(),
          ),
        ],
      ),
    );
  }

  void _toMyNtfs() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value =
          MainController.TabProfile;
    }

    if (Get.isRegistered<ProfileController>()) {
      ProfileController profileController = Get.find();
      profileController.refreshPage();
    }

    backToMain();
  }

  Widget _descriptionWidget() {
    final String textFull = 'txt_youve_just_bought'.tr.format([nftItemName]);

    final int start = textFull.indexOf(nftItemName);
    final int end = start + nftItemName.length;

    return RichText(
      text: TextSpan(
        text: textFull.substring(0, start),
        style: textTheme.bodyText2!.copyWith(
          color: SatorioColor.textBlack,
          fontSize: 17 * coefficient,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: textFull.substring(start, end),
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 17 * coefficient,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: textFull.substring(end),
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 17 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
