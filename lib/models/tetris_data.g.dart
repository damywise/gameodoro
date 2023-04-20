// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tetris_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TetrisData _$$_TetrisDataFromJson(Map<String, dynamic> json) =>
    _$_TetrisData(
      level: (json['level'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      currentBlock: json['currentBlock'] == null
          ? null
          : Block.fromJson(json['currentBlock'] as Map<String, dynamic>),
      isPlaying: json['isPlaying'] as bool,
      isPaused: json['isPaused'] as bool,
      isGameover: json['isGameover'] as bool,
    );

Map<String, dynamic> _$$_TetrisDataToJson(_$_TetrisData instance) =>
    <String, dynamic>{
      'level': instance.level,
      'currentBlock': instance.currentBlock,
      'isPlaying': instance.isPlaying,
      'isPaused': instance.isPaused,
      'isGameover': instance.isGameover,
    };
