// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Block _$$_BlockFromJson(Map<String, dynamic> json) => _$_Block(
      (json['coordinates'] as List<dynamic>)
          .map(
            (e) => (e as List<dynamic>)
                .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
                .toList(),
          )
          .toList(),
      json['index'] as int,
      (json['position'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [0, 0],
      json['rotation'] as int? ?? 0,
    );

Map<String, dynamic> _$$_BlockToJson(_$_Block instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      'index': instance.index,
      'position': instance.position,
      'rotation': instance.rotation,
    };
