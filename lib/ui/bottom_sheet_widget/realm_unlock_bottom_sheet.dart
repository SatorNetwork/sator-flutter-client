import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class RealmUnlockBottomSheet extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'images/bg/gradient_challenge_timer.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'lottie-anim/realm-unlock.json',
                    width: Get.width * 0.8,
                    onLoaded: (composition) {
                      Future.delayed(composition.duration, () {
                        Get.until((route) => Get.isOverlaysClosed);
                      });
                    },
                  ),
                  Text(
                    'txt_realm_unlocked'.tr,
                    style: textTheme.headline1!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 34.0 * coefficient,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
