import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/paid_option.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/extension.dart';

typedef SelectPaidOptionCallback = void Function(PaidOption paidOption);

class RealmExpiringBottomSheet extends StatelessWidget {
  RealmExpiringBottomSheet(
    this.episodeActivation,
    this.onExtend, {
    Key? key,
  }) : super(key: key);

  final Rx<PaidOption?> _selectedPaidOptionRx = Rx(null);

  final EpisodeActivation episodeActivation;
  final SelectPaidOptionCallback onExtend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 128 * coefficient,
                      height: 128 * coefficient,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        color: SatorioColor.interactive,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.watch_later_rounded,
                          size: 54 * coefficient,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48 * coefficient,
                    ),
                    Text(
                      'txt_realm_expiring'.tr,
                      textAlign: TextAlign.center,
                      style: textTheme.headline1!.copyWith(
                        color: Colors.white,
                        fontSize: 34 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 12 * coefficient,
                    ),
                    Text(
                      'txt_x_hours_left'.tr.format(
                        [
                          episodeActivation.leftHours(),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 18 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
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
                  Text(
                    'txt_extend_realm'.tr,
                    textAlign: TextAlign.center,
                    style: textTheme.headline3!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 28 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8 * coefficient,
                  ),
                  Text(
                    'txt_choose_option'.tr,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 18 * coefficient,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 24 * coefficient,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: PaidOption.available
                        .map((item) => _itemWidget(item))
                        .toList(),
                  ),
                  SizedBox(
                    height: 24 * coefficient,
                  ),
                  Obx(
                    () => ElevatedGradientButton(
                      text: 'txt_extend_realm'.tr,
                      isEnabled: _selectedPaidOptionRx.value != null,
                      onPressed: () {
                        Get.back();
                        if (_selectedPaidOptionRx.value != null) {
                          onExtend(_selectedPaidOptionRx.value!);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8 * coefficient,
                  ),
                  BorderedButton(
                    text: 'txt_no_thanks'.tr,
                    textColor: SatorioColor.interactive,
                    borderColor: SatorioColor.interactive,
                    borderWidth: 2,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(PaidOption paidOption) {
    return Obx(
      () => InkWell(
        onTap: () {
          _selectedPaidOptionRx.value =
              _selectedPaidOptionRx.value == paidOption ? null : paidOption;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: _selectedPaidOptionRx.value == paidOption
                ? SatorioColor.interactive.withOpacity(0.5)
                : SatorioColor.lavender,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 20 * coefficient,
                height: 20 * coefficient,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SatorioColor.razzle_dazzle_rose,
                      SatorioColor.dodger_blue
                    ],
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'images/sator_logo.svg',
                    width: 10 * coefficient,
                    height: 10 * coefficient,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 6 * coefficient,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paidOption.text,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    paidOption.amount.toStringAsFixed(2),
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
