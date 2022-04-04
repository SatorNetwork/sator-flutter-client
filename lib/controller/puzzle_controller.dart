import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:satorio/domain/entities/puzzle/position.dart';
import 'package:satorio/domain/entities/puzzle/puzzle.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_game.dart';
import 'package:satorio/domain/entities/puzzle/tile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/puzzle_image_sample_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

enum PuzzleStatus { incomplete, complete, reachedStepLimit }

class PuzzleController extends GetxController with GetTickerProviderStateMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late AnimationController animationController;
  late Animation<double> animationScale;

  late PuzzleStatus puzzleStatus = PuzzleStatus.incomplete;

  late String puzzleGameId;

  final Rx<PuzzleGame?> puzzleGameRx = Rx(null);
  final Rx<Uint8List> squareImage = Rx(Uint8List.fromList([]));
  final Rx<Puzzle?> puzzleRx = Rx(null);
  final RxInt stepsTakenRx = 0.obs;

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
    if (puzzleStatus == PuzzleStatus.incomplete) {
      Get.dialog(
        DefaultDialog(
          'txt_cancel_puzzle'.tr,
          'txt_cancel_puzzle_message'.tr,
          'txt_yes'.tr,
          icon: Icons.cancel_outlined,
          onButtonPressed: () {
            _finishPuzzle(PuzzleGameResult.notFinished)
                .then((value) => Get.back());
          },
          secondaryButtonText: 'txt_no'.tr,
        ),
      );
    } else {
      Get.back();
    }
  }

  void initPuzzle() async {
    puzzleGameRx.value = await _satorioRepository.startPuzzle(puzzleGameId);

    if (puzzleGameRx.value != null) {
      final Uint8List bytes = await _loadImage(puzzleGameRx.value!.image);

      final Uint8List squareBytes = await compute(_squareImage, bytes);
      squareImage.value = squareBytes;

      final List<Uint8List> images = await compute(
        splitImage,
        _SplitImageData(squareBytes, puzzleGameRx.value!.xSize),
      );
      final Puzzle puzzle = _generatePuzzle(
        images,
        puzzleGameRx.value!.xSize,
        shuffle: true,
      );

      puzzleRx.value = puzzle.sort();
    }
  }

  void tapTile(Tile tile) {
    if (puzzleRx.value != null && puzzleStatus == PuzzleStatus.incomplete) {
      if (puzzleRx.value!.isTileMovable(tile)) {
        final mutablePuzzle = Puzzle(tiles: [...puzzleRx.value!.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tile, []);

        puzzleRx.value = puzzle.sort();
        stepsTakenRx.value = stepsTakenRx.value + 1;
        if (puzzle.isComplete()) {
          puzzleStatus = PuzzleStatus.complete;
          _finishPuzzle(PuzzleGameResult.userWon);
        } else if (stepsTakenRx.value == puzzleGameRx.value?.steps) {
          puzzleStatus = PuzzleStatus.reachedStepLimit;
          _finishPuzzle(PuzzleGameResult.userLost);
        }
      }
    }
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

  /// Load image from url as bytes
  Future<Uint8List> _loadImage(String url) {
    return NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((value) => value.buffer.asUint8List());
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(
    List<Uint8List> images,
    int size, {
    bool shuffle = true,
  }) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile positions.
      currentPositions.shuffle();
    }

    var tiles = _getTileListFromPositions(
      size,
      images,
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle();
        tiles = _getTileListFromPositions(
          size,
          images,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Uint8List> images,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            imageBytes: images[i - 1],
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            imageBytes: images[i - 1],
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  Future<void> _finishPuzzle(int puzzleGameResult) {
    return _satorioRepository.finishPuzzle(
      puzzleGameId,
      puzzleGameResult,
      stepsTakenRx.value,
    );
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

List<Uint8List> splitImage(_SplitImageData data) {
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
