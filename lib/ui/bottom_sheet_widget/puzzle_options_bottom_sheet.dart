import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_unlock_option.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class PuzzleOptionsBottomSheet extends StatelessWidget {
  PuzzleOptionsBottomSheet(this.reward, this.puzzleOptions, this.onExtend);

  final double reward;
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
              child: Container(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 38),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'txt_puzzle_game'.tr,
                    textAlign: TextAlign.center,
                    style: textTheme.headline3!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 24 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 6 * coefficient,
                  ),
                  Text(
                    'txt_complete_picture'.tr,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 18 * coefficient,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 32 * coefficient,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * coefficient,
                    ),
                    height: 53 * coefficient,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: SatorioColor.alice_blue,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'txt_reward'.tr,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 14 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${reward.toStringAsFixed(2)} SAO',
                            textAlign: TextAlign.right,
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.interactive,
                              fontSize: 14 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 3 * coefficient,
                      color: SatorioColor.alice_blue,
                    ),
                  ),
                  SizedBox(
                    height: 16 * coefficient,
                  ),
                  Text(
                    'txt_choose_step_amount'.tr,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 14 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 24 * coefficient,
                  ),
                  SizedBox(
                    height: 86 * coefficient,
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
                    height: 38 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => ElevatedGradientButton(
                        text: 'txt_play'.tr,
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
                      borderWidth: 1,
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
              height: 86 * coefficient,
              // width: 83 * coefficient,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white
                    .withOpacity(puzzleOption.isLocked ? 0.75 : 0.0),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                border: Border.all(
                  color: _selectedPuzzleOptionRx.value == puzzleOption
                      ? SatorioColor.interactive
                      : SatorioColor.alice_blue,
                  width: 1,
                ),
                color: _selectedPuzzleOptionRx.value == puzzleOption
                    ? SatorioColor.ghost_white
                    : SatorioColor.alice_blue,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      puzzleOption.steps.toString(),
                      maxLines: 1,
                      style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 24 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 6 * coefficient,
                    ),
                    Text(
                      '${puzzleOption.amount.toStringAsFixed(2)} SAO',
                      maxLines: 1,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
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
