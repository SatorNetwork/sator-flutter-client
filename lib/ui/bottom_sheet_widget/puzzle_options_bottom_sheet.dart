import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_unlock_option.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class PuzzleOptionsBottomSheet extends StatelessWidget {
  PuzzleOptionsBottomSheet(this.puzzleOptions, this.onExtend);

  final List<PuzzleUnlockOption> puzzleOptions;
  final Function(PuzzleUnlockOption puzzleOption) onExtend;

  final Rx<PuzzleUnlockOption?> _selectedPuzzleOptionRx = Rx(null);

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
          children: [
            Expanded(
              child: Center(
                child: Container(
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
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'txt_unlock_puzzle'.tr,
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
                  SizedBox(
                    height: 56 * coefficient,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16,
                      ),
                      itemCount: puzzleOptions.length,
                      itemBuilder: (context, index) =>
                          _itemWidget(puzzleOptions[index]),
                    ),
                  ),
                  SizedBox(
                    height: 24 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => ElevatedGradientButton(
                        text: 'txt_unlock_sao'.tr,
                        isEnabled: _selectedPuzzleOptionRx.value != null,
                        onPressed: () {
                          Get.back();
                          if (_selectedPuzzleOptionRx.value != null) {
                            onExtend(_selectedPuzzleOptionRx.value!);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BorderedButton(
                      text: 'txt_no_thanks'.tr,
                      textColor: SatorioColor.interactive,
                      borderColor: SatorioColor.interactive,
                      borderWidth: 2,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(PuzzleUnlockOption puzzleOption) {
    return Obx(
      () => InkWell(
        onTap: () {
          if (!puzzleOption.isLocked) {
            _selectedPuzzleOptionRx.value =
                _selectedPuzzleOptionRx.value == puzzleOption
                    ? null
                    : puzzleOption;
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              height: 56 * coefficient,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color:
                    Colors.white.withOpacity(puzzleOption.isLocked ? 0.8 : 0.0),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: _selectedPuzzleOptionRx.value == puzzleOption
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
                        '${puzzleOption.steps} steps for',
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        puzzleOption.amount.toStringAsFixed(2),
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
            if (puzzleOption.isLocked)
              Icon(
                Icons.lock_rounded,
                color: SatorioColor.comet,
                size: 32,
              ),
          ],
        ),
      ),
    );
  }
}
