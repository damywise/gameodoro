import 'package:freezed_annotation/freezed_annotation.dart';

part 'block.freezed.dart';

part 'block.g.dart';

@freezed
class Block with _$Block {
  const factory Block(
    List<List<List<int>>> coordinates,
    int index, [
    @Default([0, 0]) List<int> position,
    @Default(0) int rotation,
  ]) = _Block;

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
}
