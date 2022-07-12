import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:satorio/domain/entities/puzzle/puzzle_game.dart';
import 'package:satorio/domain/entities/puzzle/tile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/default_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/puzzle_image_sample_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/quiz_winner_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class PuzzleController extends GetxController with GetTickerProviderStateMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late AnimationController animationController;
  late Animation<double> animationScale;

  late String puzzleGameId;

  final Rx<PuzzleGame?> puzzleGameRx = Rx(null);
  final Rx<Uint8List> squareImage = Rx(Uint8List.fromList([]));
  final Rx<List<Uint8List>> imagesRx = Rx([]);

  final RxBool isTapRequested = false.obs;

  PuzzleController() {
    this.puzzleGameId = (Get.arguments as PuzzleArgument).puzzleGameId;
  }

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 230),
    );

    animationScale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
    initPuzzle();
  }

  void back() {
    if (puzzleGameRx.value?.status == PuzzleGameStatus.inProgress) {
      Get.dialog(
        DefaultDialog(
          'txt_exit_puzzle'.tr,
          'txt_exit_puzzle_message'.tr,
          'txt_yes'.tr,
          icon: Icons.cancel_outlined,
          onButtonPressed: () {
            Get.back(closeOverlays: true);
          },
          secondaryButtonText: 'txt_no'.tr,
        ),
      );
    } else {
      Get.back();
    }
  }

  void initPuzzle() async {
    final PuzzleGame puzzleGame =
        await _satorioRepository.startPuzzle(puzzleGameId);

    final Uint8List bytes = await _loadImage(puzzleGame.image);

    final Uint8List squareBytes = await compute(_squareImage, bytes);
    squareImage.value = squareBytes;

    final List<Uint8List> images = await compute(
      _splitImage,
      _SplitImageData(squareBytes, puzzleGame.xSize),
    );
    imagesRx.value = images;

    puzzleGameRx.value = puzzleGame;
  }

  void tapTile(Tile tile) async {
    if (isTapRequested.value) return;

    Future.value(true)
        .then((value) {
          isTapRequested.value = true;
          return value;
        })
        .then((value) => _satorioRepository.tapTile(
              puzzleGameId,
              tile.currentPosition.x,
              tile.currentPosition.y,
            ))
        .then(
          (PuzzleGame puzzleGame) {
            puzzleGameRx.value = puzzleGame;
            _handlePuzzleChange();
            isTapRequested.value = false;
          },
        )
        .catchError(
          (value) {
            isTapRequested.value = false;
          },
        );
  }

  void toPuzzleImageSample() {
    if (squareImage.value.isNotEmpty) {
      Get.bottomSheet(
        PuzzleImageSampleBottomSheet(squareImage.value),
        isScrollControlled: true,
        barrierColor: Colors.transparent,
      );
    }
  }

  void _handlePuzzleChange() {
    if (puzzleGameRx.value != null) {
      switch (puzzleGameRx.value!.status) {
        case PuzzleGameStatus.stepLimit:
          Get.bottomSheet(
            DefaultBottomSheet(
              'txt_failure'.tr,
              'txt_puzzle_steps_reached'.tr,
              'txt_ok'.tr,
            ),
          ).whenComplete(
            () => Get.back(),
          );
          break;
        case PuzzleGameStatus.finished:
          HapticFeedback.vibrate();
          Get.bottomSheet(
            puzzleGameRx.value!.rewards <= 0 ||
                    puzzleGameRx.value!.isRewardsDisabled
                ? DefaultBottomSheet(
                    'txt_success'.tr,
                    'txt_puzzle_win'.tr,
                    'txt_ok'.tr,
                  )
                : QuizWinnerBottomSheet(
                    '${puzzleGameRx.value!.rewards.toStringAsFixed(2)} SAO',
                    puzzleGameRx.value!.bonusRewards > 0
                        ? '${puzzleGameRx.value!.bonusRewards.toStringAsFixed(2)} SAO'
                        : '',
                  ),
          ).whenComplete(
            () => Get.back(),
          );
          break;
      }
    }
  }

  /// Load image from url as bytes
  Future<Uint8List> _loadImage(String url) {
    return NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((value) => value.buffer.asUint8List());
  }
}

Uint8List _squareImage(List<int> bytes) {
  imageLib.Image image = imageLib.decodeImage(bytes)!;
  int squareSize = min(image.width, image.height);

  imageLib.Image squareImage =
      imageLib.copyCrop(image, 0, 0, squareSize, squareSize);

  return Uint8List.fromList(
    imageLib.encodeJpg(squareImage),
  );
}

List<Uint8List> _splitImage(_SplitImageData data) {
  // convert to image from image package
  imageLib.Image image = imageLib.decodeImage(data.bytes)!;

  int x = 0, y = 0;

  int width, height;
  width = (image.width / data.size).round();
  height = (image.height / data.size).round();

  // split image to parts
  List<imageLib.Image> parts = [];
  for (int i = 0; i < data.size; i++) {
    for (int j = 0; j < data.size; j++) {
      parts.add(imageLib.copyCrop(image, x, y, width, height));
      x += width;
    }
    x = 0;
    y += height;
  }

  return parts
      .map(
        (e) => Uint8List.fromList(
          imageLib.encodeJpg(e),
        ),
      )
      .toList();
}

class _SplitImageData {
  final List<int> bytes;
  final int size;

  const _SplitImageData(this.bytes, this.size);
}

class PuzzleArgument {
  final String puzzleGameId;

  const PuzzleArgument(this.puzzleGameId);
}
