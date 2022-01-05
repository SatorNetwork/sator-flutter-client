import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/smile_list.dart';

typedef RateCallback = void Function(int rate);

class RateBottomSheet extends StatelessWidget {
  RateBottomSheet(
    this.onRate, {
    Key? key,
    this.isZeroSeason = false,
  }) : super(key: key);

  static const int minValue = 1;
  static const int maxValue = 10;
  static const int initValue = 10;

  final bool isZeroSeason;
  final RateCallback onRate;
  final RxInt rateRx = initValue.obs;

  double get paddingH => 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
                    isZeroSeason
                        ? 'txt_rate_content'.tr
                        : 'txt_rate_episode'.tr,
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
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32 * coefficient),
            child: Obx(
              () => SvgPicture.asset(
                smile[rateRx.value] ?? '',
                width: 128 * coefficient,
                height: 128 * coefficient,
              ),
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
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Obx(
              () => Slider(
                onChanged: (value) {
                  rateRx.value = value.toInt();
                },
                divisions: (maxValue - minValue).toInt(),
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
