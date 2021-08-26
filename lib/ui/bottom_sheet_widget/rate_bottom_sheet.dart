import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

typedef RateCallback = void Function(int rate);

class RateBottomSheet extends StatelessWidget {
  RateBottomSheet(
    this.onRate, {
    Key? key,
  }) : super(key: key);

  static const int minValue = 1;
  static const int maxValue = 10;
  static const int initValue = 7;

  final RateCallback onRate;
  final RxInt rateRx = initValue.obs;

  double get paddingH => 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 18 * coefficient,
                    color: SatorioColor.textBlack,
                  ),
                  SizedBox(
                    width: 12 * coefficient,
                  ),
                  Text(
                    'txt_rate_episode'.tr,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 13 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32 * coefficient),
            child: SvgPicture.asset(
              'images/smile_rate.svg',
              width: 128 * coefficient,
              height: 128 * coefficient,
            ),
          ),
          Obx(
            () => Text(
              rateRx.value.toStringAsFixed(0),
              style: textTheme.headline2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 32 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 32 * coefficient,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingH),
            child: Obx(
              () => Slider(
                onChanged: (value) {
                  rateRx.value = value.toInt();
                },
                divisions: maxValue.toInt(),
                min: minValue.toDouble(),
                max: maxValue.toDouble(),
                value: rateRx.value.toDouble(),
                activeColor: SatorioColor.interactive,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingH),
            child: ElevatedGradientButton(
              text: 'txt_rate'.tr,
              onPressed: () {
                Get.back();
                onRate(rateRx.value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
