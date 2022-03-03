import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/splash_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.dummy();
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
          Padding(
            padding: EdgeInsets.only(
              left: 40 * coefficient,
              right: 40 * coefficient,
              bottom: 116 * coefficient,
              // top: Get.mediaQuery.padding.top,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: SvgPicture.asset(
                        'images/splash.svg',
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'images/sator_colored.svg',
                  height: 54 * coefficient,
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
