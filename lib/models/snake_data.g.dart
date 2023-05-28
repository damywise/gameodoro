// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snake_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SnakeData _$$_SnakeDataFromJson(Map<String, dynamic> json) => _$_SnakeData(
      level: (json['level'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      pos: (json['pos'] as List<dynamic>)
          .map((e) => SnakePos.fromJson(e as Map<String, dynamic>))
          .toList(),
      length: json['length'] as int,
      direction: $enumDecode(_$AxisDirectionEnumMap, json['direction']),
      isPlaying: json['isPlaying'] as bool,
      isPaused: json['isPaused'] as bool,
      isGameover: json['isGameover'] as bool,
    );

Map<String, dynamic> _$$_SnakeDataToJson(_$_SnakeData instance) =>
    <String, dynamic>{
      'level': instance.level,
      'pos': instance.pos,
      'length': instance.length,
      'direction': _$AxisDirectionEnumMap[instance.direction]!,
      'isPlaying': instance.isPlaying,
      'isPaused': instance.isPaused,
      'isGameover': instance.isGameover,
    };

const _$AxisDirectionEnumMap = {
  AxisDirection.up: 'up',
  AxisDirection.right: 'right',
  AxisDirection.down: 'down',
  AxisDirection.left: 'left',
};
