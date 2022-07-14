import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/puzzle_controller.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_game.dart';
import 'package:satorio/domain/entities/puzzle/tile.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';

class PuzzlePage extends GetView<PuzzleController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.back();
        return Future.value(false);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'txt_puzzle'.tr,
            style: textTheme.bodyText1!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Material(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child: InkWell(
              onTap: () => controller.back(),
              child: Icon(
                Icons.chevron_left_rounded,
                color: SatorioColor.darkAccent,
                size: 32,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.toPuzzleImageSample();
              },
              icon: Icon(
                Icons.image_outlined,
                color: SatorioColor.darkAccent,
                size: 24,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            backgroundImage('images/bg/gradient.svg'),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(
                  top: Get.mediaQuery.padding.top + kToolbarHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 48,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'txt_complete_picture'.tr,
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.darkAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 6 * coefficient,
                      ),
                      Obx(
                        () => Text(
                          puzzleGame.value == null ||
                                  puzzleGame.value!.prizePool <= 0 ||
                                  !puzzleGame.value!.isRewardsEnabled
                              ? ''
                              : 'txt_you_will_get'.tr.format(
                                  [
                                    puzzleGame.value!.prizePool
                                        .toStringAsFixed(2)
                                  ],
                                ),
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 46 * coefficient,
                      ),
                      Obx(
                        () => puzzleGame.value == null
                            ? Container(
                                width: Get.width - 2 * 20,
                                height: Get.width - 2 * 20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: SatorioColor.brand,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.square(
                                key: const Key('puzzle_board'),
                                dimension: Get.width - 2 * 20,
                                child: Stack(
                                  key: const Key('puzzle_tiles'),
                                  children: puzzleGame.value!.tiles
                                      .map(
                                        (tile) => _tileWidget(
                                          tile,
                                          controller
                                              .imagesRx.value[tile.value - 1],
                                          puzzleGame.value!.xSize,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  _stepsCountText(puzzleGame.value),
                                  style: textTheme.bodyText1!.copyWith(
                                    fontSize: 24 * coefficient,
                                    fontWeight: FontWeight.w700,
                                    color: puzzleGame.value?.stepsTaken ==
                                            puzzleGame.value?.steps
                                        ? SatorioColor.error
                                        : SatorioColor.darkAccent,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  _steps(puzzleGame.value),
                                  style: textTheme.bodyText1!.copyWith(
                                    fontSize: 18 * coefficient,
                                    fontWeight: FontWeight.w400,
                                    color: SatorioColor.darkAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tileWidget(
      final Tile tile, final Uint8List imageBytes, final int size) {
    return AnimatedAlign(
      key: Key('puzzle_tile_align_${tile.value}'),
      alignment: FractionalOffset(
        (tile.currentPosition.x - 1) / (size - 1),
        (tile.currentPosition.y - 1) / (size - 1),
      ),
      duration: Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      child: SizedBox.square(
        key: Key('puzzle_tile_${tile.value}'),
        dimension: (Get.width - 2 * 20) / size + 2 * size,
        child: ScaleTransition(
          key: Key('puzzle_tile_scale_${tile.value}'),
          scale: controller.animationScale,
          child: IconButton(
            onPressed: tile.isWhitespace
                ? null
                : () {
                    controller.tapTile(tile);
                  },
            icon: tile.isWhitespace
                ? SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    child: Image.memory(imageBytes),
                  ),
          ),
        ),
      ),
    );
  }

  Rx<PuzzleGame?> get puzzleGame => controller.puzzleGameRx;

  String _stepsCountText(PuzzleGame? puzzleGame) {
    if (puzzleGame == null) {
      return '';
    } else if (puzzleGame.isRewardsEnabled) {
      return 'txt_steps_left_of_steps'
          .tr
          .format([puzzleGame.steps - puzzleGame.stepsTaken, puzzleGame.steps]);
    } else {
      return puzzleGame.stepsTaken.toString();
    }
  }

  String _steps(PuzzleGame? puzzleGame) {
    if (puzzleGame == null) {
      return '';
    } else if (puzzleGame.isRewardsEnabled) {
      return 'txt_steps_left'.tr;
    } else {
      return 'txt_steps'.tr;
    }
  }
}
