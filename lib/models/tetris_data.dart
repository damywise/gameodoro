import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameodoro/models/block.dart';

part 'tetris_data.freezed.dart';
part 'tetris_data.g.dart';

@freezed
class TetrisData with _$TetrisData {
  const factory TetrisData({
    required List<List<int>> level,
    required Block? currentBlock,
    required bool isPlaying,
    required bool isPaused,
    required bool isGameover,
  }) = _TetrisData;

  factory TetrisData.fromJson(Map<String, dynamic> json) =>
      _$TetrisDataFromJson(json);
}
