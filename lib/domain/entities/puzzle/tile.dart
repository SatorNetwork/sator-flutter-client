import 'package:equatable/equatable.dart';
import 'package:satorio/domain/entities/puzzle/position.dart';

class Tile extends Equatable {
  const Tile(
    this.value,
    this.currentPosition,
    this.isWhitespace,
  );

  /// Value representing the correct position of [Tile] in a list.
  final int value;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value,
      currentPosition,
      isWhitespace,
    );
  }

  @override
  List<Object> get props => [
        value,
        currentPosition,
        isWhitespace,
      ];
}
