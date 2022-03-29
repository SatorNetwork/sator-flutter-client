import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:satorio/domain/puzzle/position.dart';

class Tile extends Equatable {
  const Tile({
    required this.imageBytes,
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    this.isWhitespace = false,
  });

  /// Value representing the image of [Tile].
  final Uint8List imageBytes;

  /// Value representing the correct position of [Tile] in a list.
  final int value;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      imageBytes: imageBytes,
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
        imageBytes,
        value,
        correctPosition,
        currentPosition,
        isWhitespace,
      ];
}
