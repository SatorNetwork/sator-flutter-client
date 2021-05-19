import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ProfilePage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'txt_profile'.tr,
          style: TextStyle(
              color: SatorioColor.darkAccent,
              fontSize: 22.0,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(),
    );
  }
}
