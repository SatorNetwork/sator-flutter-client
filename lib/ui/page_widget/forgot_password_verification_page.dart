import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/password_recovery_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ForgotPasswordVerificationPage
    extends GetView<PasswordRecoveryController> {
  static const double _appBarHeight = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: _appBarHeight,
        iconTheme: IconThemeData(color: SatorioColor.darkAccent),
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: SatorioColor.darkAccent,
              size: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.mediaQuery.size.height -
              (Get.mediaQuery.padding.top + _appBarHeight),
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(),
        ),
      ),
    );
  }
}
