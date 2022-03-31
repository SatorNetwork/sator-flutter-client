import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/puzzle_controller.dart';
import 'package:satorio/domain/entities/puzzle/puzzle.dart';
import 'package:satorio/domain/entities/puzzle/tile.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';

class PuzzlePage extends GetView<PuzzleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            width: kToolbarHeight,
            height: kToolbarHeight,
            child: IconButton(
              onPressed: () {
                controller.toInfo();
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: SatorioColor.darkAccent,
                size: 24,
              ),
            ),
          )
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
              child: Obx(
                () => controller.puzzleRx.value == null
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: SatorioColor.brand,
                          ),
                        ),
                      )
                    : _puzzleGame(controller.puzzleRx.value!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _puzzleGame(final Puzzle puzzle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
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
          Text(
            'txt_you_will_get'
                .tr
                .format([controller.puzzleGame.rewards.toStringAsFixed(2)]),
            style: textTheme.bodyText1!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 46 * coefficient,
          ),
          SizedBox.square(
            key: const Key('puzzle_board'),
            dimension: Get.width - 2 * 20,
            child: Stack(
              key: const Key('puzzle_tiles'),
              children: puzzle.tiles
                  .map((tile) => _tileWidget(tile, puzzle.getDimension()))
                  .toList(),
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'txt_steps_taken_of_steps'.tr.format([
                      controller.numberOfMovesRx.value,
                      controller.puzzleGame.steps
                    ]),
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 24 * coefficient,
                      fontWeight: FontWeight.w700,
                      color: SatorioColor.darkAccent,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n${'txt_steps_left'.tr}',
                        style: textTheme.bodyText1!.copyWith(
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w400,
                          color: SatorioColor.darkAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tileWidget(final Tile tile, final int size) {
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
        dimension: Get.width / size,
        child: ScaleTransition(
          key: Key('puzzle_tile_scale_${tile.value}'),
          scale: controller.animationScale,
          child: IconButton(
            onPressed: tile.isWhitespace
                ? null
                : () {
                    controller.tapTile(tile);
                  },
            icon:
                tile.isWhitespace ? SizedBox() : Image.memory(tile.imageBytes),
          ),
        ),
      ),
    );
  }
}
