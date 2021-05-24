import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/splash_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.dummy();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: SatorioColor.royal_blue,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 70),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'images/sator.svg',
                    height: 36,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Curabitur posuere, dolor quis commodo vulputate, odio nunc maximus ex, sed faucibus elit ex',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.79),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
