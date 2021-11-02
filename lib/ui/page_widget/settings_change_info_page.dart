import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/settings_change_info_controller.dart';
import 'package:satorio/domain/entities/change_info_type.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
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
          _changeInfoTitle(),
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
            child: _changeInfoContent()),
      ),
    );
  }

  Widget _changeInfoContent() {
    switch (controller.type) {
      case ChangeInfoType.email:
        return _changeEmail();
      case ChangeInfoType.username:
        return _changeUserName();
      case ChangeInfoType.password:
        return _changePassword();
      default:
        return Container();
    }
  }

  String _changeInfoTitle() {
    switch (controller.type) {
      case ChangeInfoType.email:
        return 'txt_settings_email'.tr;
      case ChangeInfoType.username:
        return 'txt_user_name'.tr;
      case ChangeInfoType.password:
        return 'txt_password'.tr;
      default:
        return '';
    }
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
            isInProgress: controller.isRequested.value,
            onPressed: () {
              controller.updateUsername();
            },
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

  Widget _changePassword() {
    return Column(
      children: [
        Obx(
          () => InputTextField(
            inputTitle: 'txt_old_password'.tr,
            controller: controller.oldPasswordController,
            hintText: 'txt_password_hint'.tr,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: controller.oldPasswordObscured.value,
            errorText: controller.validationRx.value['old_password'],
            icon: Icon(
                controller.oldPasswordObscured.value
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye_outlined,
                color: SatorioColor.darkAccent),
            onPressedIcon: () {
              controller.oldPasswordObscured.toggle();
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Obx(
              () => InputTextField(
            inputTitle: 'txt_new_password'.tr,
            controller: controller.newPasswordController,
            hintText: 'txt_password_hint'.tr,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: controller.newPasswordObscured.value,
            errorText: controller.validationRx.value['new_password'],
            icon: Icon(
                controller.newPasswordObscured.value
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye_outlined,
                color: SatorioColor.darkAccent),
            onPressedIcon: () {
              controller.newPasswordObscured.toggle();
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Obx(
          () => ElevatedGradientButton(
            text: 'txt_change_password'.tr,
            isEnabled: controller.oldPasswordRx.value.isNotEmpty && controller.newPasswordRx.value.isNotEmpty,
            isInProgress: controller.isRequested.value,
            onPressed: () {
              controller.changePassword();
            },
          ),
        ),
      ],
    );
  }
}
