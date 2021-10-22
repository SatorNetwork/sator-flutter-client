import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/settings_change_info_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class SettingsChangeInfoPage extends GetView<SettingsChangeInfoController> {
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
          controller.isChangeEmail
              ? 'txt_settings_email'.tr
              : 'txt_user_name'.tr,
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
        margin: const EdgeInsets.only(top: 100),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child:
                controller.isChangeEmail ? _changeEmail() : _changeUserName()),
      ),
    );
  }

  Widget _changeUserName() {
    return Column(
      children: [
        Obx(
          () => InputTextField(
            inputTitle: 'txt_username'.tr,
            controller: controller.usernameController,
            hintText: 'txt_username_hint'.tr,
            obscureText: false,
            errorText: controller.validationRx.value['username'],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Obx(
          () => ElevatedGradientButton(
            text: 'txt_change_user_name'.tr,
            isEnabled: controller.usernameRx.value.isNotEmpty,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _changeEmail() {
    return Column(
      children: [
        Obx(
          () => InputTextField(
            inputTitle: 'txt_email_address'.tr,
            controller: controller.emailController,
            obscureText: false,
            enableSuggestions: false,
            autocorrect: false,
            errorText: controller.validationRx.value['email'],
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Obx(
          () => ElevatedGradientButton(
            text: 'txt_change_email'.tr,
            isEnabled: controller.emailRx.value.isNotEmpty,
            isInProgress: controller.isRequested.value,
            onPressed: () {
              controller.requestUpdateEmail();
            },
          ),
        ),
      ],
    );
  }
}
