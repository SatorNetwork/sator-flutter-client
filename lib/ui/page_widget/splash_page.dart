import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/splash_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'images/bg/splash.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: SvgPicture.asset(
              'images/sator_colored.svg',
              height: 54 * coefficient,
            ),
          ),
        ],
      ),
    );
  }
}
