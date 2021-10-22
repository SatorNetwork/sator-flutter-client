import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/settings_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_settings'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: Colors.black,
            fontSize: 17 * coefficient,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            height: kToolbarHeight,
            width: kToolbarHeight,
            child: InkWell(
              onTap: () {
                controller.back();
              },
              child: Icon(
                Icons.close,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: SatorioColor.darkAccent,
            child: Column(
              children: [
                SvgPicture.asset(
                  'images/bg/gradient.svg',
                  height: Get.height - 56,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height - 100,
            margin: const EdgeInsets.only(top: 100),
            // width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _settingsTitle('txt_profile'.tr),
                SizedBox(
                  height: 14,
                ),
                _profileGroup(),
                SizedBox(
                  height: 32,
                ),
                _settingsTitle('txt_app'.tr),
                SizedBox(
                  height: 14,
                ),
                _appGroup()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profileGroup() {
    return Column(
      children: [
        _settingsButton('txt_user_name'.tr, 'images/profile',
            () => controller.toNonWorkingDialog()),
        SizedBox(
          height: 12,
        ),
        _settingsButton('txt_avatar'.tr, 'images/profile',
            () => controller.toSelectAvatar()),
        SizedBox(
          height: 12,
        ),
        _settingsButton('txt_settings_email'.tr, 'images/profile',
            () => controller.toNonWorkingDialog()),
      ],
    );
  }

  Widget _appGroup() {
    return Column(
      children: [
        _settingsButton('txt_rate_sator'.tr, 'images/profile',
            () => controller.toNonWorkingDialog()),
        SizedBox(
          height: 12,
        ),
        _settingsButton('txt_report_bug'.tr, 'images/profile',
            () => controller.toNonWorkingDialog()),
        SizedBox(
          height: 12,
        ),
        _settingsButton('txt_help'.tr, 'images/profile',
            () => controller.toNonWorkingDialog()),
        SizedBox(
          height: 12,
        ),
        _settingsButton('txt_about'.tr, 'images/profile',
            () => controller.toNonWorkingDialog()),
      ],
    );
  }

  Widget _settingsButton(String title, String icon, Function onTap) {
    return InkWell(
      onTap: onTap as void Function(),
      child: Container(
        height: 56,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: SatorioColor.alice_blue,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              '$icon.svg',
              color: SatorioColor.darkAccent,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontSize: 16 * coefficient,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: SatorioColor.interactive,
            )
          ],
        ),
      ),
    );
  }

  Widget _settingsTitle(String title) {
    return Text(
      title,
      style: textTheme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: 15 * coefficient,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
