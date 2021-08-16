import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class EpisodeRealmDialog extends StatelessWidget {
  final VoidCallback? onStartQuizPressed;
  final VoidCallback? onScanQrPressed;

  const EpisodeRealmDialog(
      {Key? key, this.onStartQuizPressed, this.onScanQrPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'txt_enter_episode_realm'.tr,
                  style: textTheme.headline4!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 24.0 * coefficient,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 69 * coefficient,
                      child: Center(
                          child: Text(
                        '1',
                        style: textTheme.headline4!.copyWith(
                            color: SatorioColor.interactive,
                            fontSize: 28.0 * coefficient,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                    Expanded(
                      child: Text(
                        'txt_enter_episode_realm_step_1'.tr,
                        textAlign: TextAlign.start,
                        style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 14.0 * coefficient,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 69 * coefficient,
                      child: Center(
                          child: Text(
                        '2',
                        style: textTheme.headline4!.copyWith(
                            color: SatorioColor.interactive,
                            fontSize: 28.0 * coefficient,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                    Expanded(
                      child: Text(
                        'txt_enter_episode_realm_step_2'.tr,
                        textAlign: TextAlign.start,
                        style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 14.0 * coefficient,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 69 * coefficient,
                      child: Center(
                          child: Text(
                        '3',
                        style: textTheme.headline4!.copyWith(
                            color: SatorioColor.interactive,
                            fontSize: 28.0 * coefficient,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                    Expanded(
                      child: Text(
                        'txt_enter_episode_realm_step_3'.tr,
                        textAlign: TextAlign.start,
                        style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 14.0 * coefficient,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32 * coefficient,
                ),
                ElevatedGradientButton(
                    text: 'txt_start_entrance_quiz'.tr,
                    onPressed: onStartQuizPressed),
                SizedBox(
                  height: 8 * coefficient,
                ),
                BorderedButton(
                    text: 'txt_qr_scan'.tr,
                    textColor: SatorioColor.interactive,
                    borderColor: SatorioColor.interactive,
                    borderWidth: 2,
                    onPressed: onScanQrPressed),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.close_rounded,
                size: 24,
                color: SatorioColor.textBlack,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
