import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';

class QuizWinnerBottomSheet extends StatelessWidget {
  final String prize;
  final String bonus;

  const QuizWinnerBottomSheet(this.prize, this.bonus);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'txt_your_total_reward'.tr,
            style: textTheme.headline3!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 20 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 4 * coefficient,
          ),
          Text(
            prize,
            style: textTheme.headline1!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 34 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: bonus.isEmpty ? 0 : 24 * coefficient,
          ),
          bonus.isEmpty
              ? SizedBox(
                  height: 0,
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(16 * coefficient),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SatorioColor.lavender2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '🔥',
                        style: textTheme.headline1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 34 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'txt_includes_bonus'.tr,
                        style: textTheme.headline1!.copyWith(
                          color: SatorioColor.interactive,
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        bonus,
                        style: textTheme.headline1!.copyWith(
                          color: SatorioColor.interactive,
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
          SizedBox(
            height: 20 * coefficient,
          ),
          BorderedButton(
            text: 'txt_back'.tr,
            textColor: SatorioColor.darkAccent,
            borderColor: SatorioColor.smalt.withOpacity(0.24),
            onPressed: () {
              Get.back();
            },
          ),
          SizedBox(
            height: 32 * coefficient,
          ),
        ],
      ),
    );
  }
}
