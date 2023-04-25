// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToDoListData _$$_ToDoListDataFromJson(Map<String, dynamic> json) =>
    _$_ToDoListData(
      (json['tasksTodo'] as List<dynamic>?)
              ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      (json['tasksDone'] as List<dynamic>?)
              ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      json['length'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ToDoListDataToJson(_$_ToDoListData instance) =>
    <String, dynamic>{
      'tasksTodo': instance.tasksTodo,
      'tasksDone': instance.tasksDone,
      'length': instance.length,
    };

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      json['id'] as int,
      json['content'] as String,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
    };
