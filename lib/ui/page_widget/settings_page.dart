import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/settings_controller.dart';
import 'package:satorio/domain/entities/change_info_type.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';

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
                controller.backToMain();
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
          backgroundImage('images/bg/gradient.svg'),
          Container(
            height: Get.height,
            margin: EdgeInsets.only(
              top: kToolbarHeight + Get.mediaQuery.padding.top,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24),
                  width: Get.width,
                  child: _settingsContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        _appGroup(),
        SizedBox(
          height: 14,
        ),
        _buttonsGroup()
      ],
    );
  }

  Widget _profileGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _settingsButton(
          'txt_user_name'.tr,
          'images/profile',
          () => controller.toChangeInfo(ChangeInfoType.username),
        ),
        SizedBox(
          height: 12,
        ),
        _settingsButton(
          'txt_avatar'.tr,
          'images/settings/ico_avatar',
          () => controller.toSelectAvatar(),
        ),
        SizedBox(
          height: 12,
        ),
        _settingsButton(
          'txt_settings_email'.tr,
          'images/settings/ico_email',
          () => controller.toChangeInfo(ChangeInfoType.email),
        ),
        SizedBox(
          height: 12,
        ),
        _settingsButton(
          'txt_password'.tr,
          'images/settings/ico_pass',
          () => controller.toChangeInfo(ChangeInfoType.password),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
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
              Icon(Icons.fingerprint, color: SatorioColor.darkAccent),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  'txt_login_biometric_title'.tr,
                  style: textTheme.bodyText1!.copyWith(
                    color: Colors.black,
                    fontSize: 16 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Obx(
                () => FlutterSwitch(
                  value: controller.isBiometric.value,
                  height: 24,
                  width: 46,
                  padding: 1,
                  toggleSize: 24,
                  duration: Duration(milliseconds: 0),
                  activeColor: SatorioColor.brand,
                  inactiveColor: SatorioColor.alice_blue2,
                  onToggle: (bool value) {
                    controller.toggleBiometric(value);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonsGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BorderedButton(
          text: 'txt_log_out'.tr,
          textColor: SatorioColor.interactive,
          borderColor: SatorioColor.interactive,
          borderWidth: 2,
          onPressed: () {
            controller.toLogoutDialog();
          },
        ),
        SizedBox(
          height: 16,
        ),
        BorderedButton(
          text: 'txt_delete_account'.tr,
          textColor: SatorioColor.brand,
          borderColor: SatorioColor.brand,
          borderWidth: 2,
          onPressed: () {
            controller.toDeleteAccountDialog();
          },
        )
      ],
    );
  }

  Widget _appGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //TODO: uncomment
        // _settingsButton(
        //   'txt_rate_sator'.tr,
        //   'images/settings/ico_star',
        //   () => controller.toNonWorkingDialog(),
        // ),
        // SizedBox(
        //   height: 12,
        // ),
        // _settingsButton(
        //   'txt_report_bug'.tr,
        //   'images/settings/ico_danger',
        //   () => controller.toNonWorkingDialog(),
        // ),
        // SizedBox(
        //   height: 12,
        // ),
        _settingsButton(
          'txt_help'.tr,
          'images/settings/ico_help',
          () => controller.sendEmailToSupport(),
        ),
        SizedBox(
          height: 12,
        ),
        _settingsButton(
          'txt_about'.tr,
          'images/settings/ico_document',
          () => controller.toAbout(),
        ),
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
