import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/settings_about_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/links.dart';

class SettingsAboutPage extends GetView<SettingsAboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_about'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: Colors.black,
            fontSize: 17 * coefficient,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          height: kToolbarHeight,
          width: kToolbarHeight,
          child: InkWell(
            onTap: () {
              controller.back();
            },
            child: Icon(
              Icons.chevron_left,
              size: 32,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Container(
            height: kToolbarHeight,
            width: kToolbarHeight,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: kToolbarHeight + Get.mediaQuery.padding.top,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24),
          child: _aboutContent(),
        ),
      ),
    );
  }

  Widget _aboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _aboutButton(
            'txt_policy'.tr, () => controller.toWebPage(linkPrivacyPolicy)),
        _aboutButton(
            'txt_terms'.tr, () => controller.toWebPage(linkTermsOfUse)),
      ],
    );
  }

  Widget _aboutButton(String title, Function onTap) {
    return InkWell(
      onTap: onTap as void Function(),
      child: Container(
        height: 50,
        width: Get.width,
        padding: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.08),
              width: 1 * coefficient,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              size: 28,
              color: Colors.black.withOpacity(0.2),
            )
          ],
        ),
      ),
    );
  }
}
