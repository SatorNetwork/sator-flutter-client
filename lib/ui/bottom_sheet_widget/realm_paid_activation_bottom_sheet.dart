import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

typedef SelectPaidActivationRealmItemCallback = void Function(
    PaidActivationRealmItem paidActivationRealmItem);

class RealmPaidActivationBottomSheet extends StatelessWidget {
  RealmPaidActivationBottomSheet(
    this.onExtend, {
    Key? key,
  }) : super(key: key);

  final Rx<PaidActivationRealmItem?> _selectedItemRx = Rx(null);

  final SelectPaidActivationRealmItemCallback onExtend;

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
                        child: SvgPicture.asset(
                          'images/locked_icon.svg',
                          width: 54 * coefficient,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48 * coefficient,
                    ),
                    Text(
                      'txt_unlock_the_realm'.tr,
                      textAlign: TextAlign.center,
                      style: textTheme.headline1!.copyWith(
                        color: Colors.white,
                        fontSize: 34 * coefficient,
                        fontWeight: FontWeight.w700,
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
                    'txt_unlock_the_realm'.tr,
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
                    children:
                        _itemsTmp.map((item) => _itemWidget(item)).toList(),
                  ),
                  SizedBox(
                    height: 24 * coefficient,
                  ),
                  Obx(
                    () => ElevatedGradientButton(
                      text: 'txt_unlock_with_sao'.tr,
                      isEnabled: _selectedItemRx.value != null,
                      onPressed: () {
                        Get.back();
                        if (_selectedItemRx.value != null) {
                          onExtend(_selectedItemRx.value!);
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

  Widget _itemWidget(PaidActivationRealmItem item) {
    return Obx(
      () => InkWell(
        onTap: () {
          _selectedItemRx.value = _selectedItemRx.value == item ? null : item;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: _selectedItemRx.value == item
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
                  child: Icon(
                    SatorIcons.logo,
                    size: 16 * coefficient,
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
                    item.text,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    item.amount.toStringAsFixed(2),
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

  final List<PaidActivationRealmItem> _itemsTmp = [
    PaidActivationRealmItem('2h for', 10.0, 2),
    PaidActivationRealmItem('24h for', 100.0, 24),
    PaidActivationRealmItem('week for', 500.0, 7 * 24),
  ];
}

class PaidActivationRealmItem {
  final String text;
  final double amount;
  final int hours;

  const PaidActivationRealmItem(this.text, this.amount, this.hours);
}
