import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'snake_data.freezed.dart';

part 'snake_data.g.dart';

class SnakePos {
  SnakePos({required this.x, required this.y,});

  SnakePos.fromJson(Map<String, dynamic> json)
      : x = json['x'] as int,
        y = json['y'] as int;
  int x;
  int y;

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}

@freezed
class SnakeData with _$SnakeData {
  const factory SnakeData({
    required List<List<int>> level,
    required List<SnakePos> pos,
    required int length,
    required AxisDirection direction,
    required bool isPlaying,
    required bool isPaused,
    required bool isGameover,
  }) = _SnakeData;

  factory SnakeData.fromJson(Map<String, dynamic> json) =>
      _$SnakeDataFromJson(json);
}
