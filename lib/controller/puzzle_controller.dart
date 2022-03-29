import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:satorio/domain/puzzle/position.dart';
import 'package:satorio/domain/puzzle/puzzle.dart';
import 'package:satorio/domain/puzzle/tile.dart';

enum PuzzleStatus { incomplete, complete }

class PuzzleController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const String _imageUrl =
      'https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-%EC%83%98%ED%94%8C-%EC%A7%80-%EB%B9%A8%EA%B0%84%EC%83%89-%EB%9D%BC%EC%9A%B4%EB%93%9C-%EC%8A%A4%ED%83%AC%ED%94%84.jpg';
  final int sideSize = 4;

  late AnimationController animationController;
  late Animation<double> animationScale;

  late PuzzleStatus puzzleStatus = PuzzleStatus.incomplete;
  int numberOfMoves = 0;

  final Rx<Puzzle?> puzzleRx = Rx(null);

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
    initPuzzle();
  }

  void back() {
    Get.back();
  }

  void initPuzzle() async {
    final Uint8List bytes = await _loadImage();

    final List<imageLib.Image> images = _splitImage(bytes);
    final Puzzle puzzle = _generatePuzzle(images, sideSize, shuffle: true);

    puzzleRx.value = puzzle.sort();
  }

  Future<Uint8List> _loadImage() {
    return NetworkAssetBundle(Uri.parse(_imageUrl))
        .load(_imageUrl)
        .then((value) => value.buffer.asUint8List());
  }

  List<imageLib.Image> _splitImage(List<int> input) {
    // convert to image from image package
    imageLib.Image image = imageLib.decodeImage(input)!;

    int x = 0, y = 0;
    int width = (image.width / sideSize).round();
    int height = (image.height / sideSize).round();

    // split image to parts
    List<imageLib.Image> parts = [];
    for (int i = 0; i < sideSize; i++) {
      for (int j = 0; j < sideSize; j++) {
        parts.add(imageLib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }
    print(parts.length);
    return parts;
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(
    List<imageLib.Image> images,
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

    puzzle.tiles.forEach((element) {
      print(
          'tile ${element.value} ${element.currentPosition} / ${element.currentPosition} / ${element.isWhitespace}');
    });
    print('puzzle.tiles = ${puzzle.tiles.length}');
    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<imageLib.Image> images,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            imageBytes: Uint8List.fromList(
              imageLib.encodeJpg(images[i - 1]),
            ),
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            imageBytes: Uint8List.fromList(
              imageLib.encodeJpg(images[i - 1]),
            ),
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  void tapTile(Tile tile) {
    if (puzzleRx.value != null && puzzleStatus == PuzzleStatus.incomplete) {
      if (puzzleRx.value!.isTileMovable(tile)) {
        final mutablePuzzle = Puzzle(tiles: [...puzzleRx.value!.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tile, []);

        puzzleRx.value = puzzle.sort();
        numberOfMoves = numberOfMoves + 1;
        if (puzzle.isComplete()) {
          puzzleStatus = PuzzleStatus.complete;
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Puzzle complete in $numberOfMoves steps!'),
            ),
          );
        }
      }
    }
  }
}

