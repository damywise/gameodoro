// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'to_do_list_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ToDoListData _$ToDoListDataFromJson(Map<String, dynamic> json) {
  return _ToDoListData.fromJson(json);
}

/// @nodoc
mixin _$ToDoListData {
  List<Task> get tasksTodo => throw _privateConstructorUsedError;
  List<Task> get tasksDone => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToDoListDataCopyWith<ToDoListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToDoListDataCopyWith<$Res> {
  factory $ToDoListDataCopyWith(
          ToDoListData value, $Res Function(ToDoListData) then) =
      _$ToDoListDataCopyWithImpl<$Res, ToDoListData>;
  @useResult
  $Res call({List<Task> tasksTodo, List<Task> tasksDone, int length});
}

/// @nodoc
class _$ToDoListDataCopyWithImpl<$Res, $Val extends ToDoListData>
    implements $ToDoListDataCopyWith<$Res> {
  _$ToDoListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasksTodo = null,
    Object? tasksDone = null,
    Object? length = null,
  }) {
    return _then(_value.copyWith(
      tasksTodo: null == tasksTodo
          ? _value.tasksTodo
          : tasksTodo // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      tasksDone: null == tasksDone
          ? _value.tasksDone
          : tasksDone // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ToDoListDataCopyWith<$Res>
    implements $ToDoListDataCopyWith<$Res> {
  factory _$$_ToDoListDataCopyWith(
          _$_ToDoListData value, $Res Function(_$_ToDoListData) then) =
      __$$_ToDoListDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> tasksTodo, List<Task> tasksDone, int length});
}

/// @nodoc
class __$$_ToDoListDataCopyWithImpl<$Res>
    extends _$ToDoListDataCopyWithImpl<$Res, _$_ToDoListData>
    implements _$$_ToDoListDataCopyWith<$Res> {
  __$$_ToDoListDataCopyWithImpl(
      _$_ToDoListData _value, $Res Function(_$_ToDoListData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasksTodo = null,
    Object? tasksDone = null,
    Object? length = null,
  }) {
    return _then(_$_ToDoListData(
      null == tasksTodo
          ? _value._tasksTodo
          : tasksTodo // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      null == tasksDone
          ? _value._tasksDone
          : tasksDone // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ToDoListData implements _ToDoListData {
  _$_ToDoListData(
      [final List<Task> tasksTodo = const [],
      final List<Task> tasksDone = const [],
      this.length = 0])
      : _tasksTodo = tasksTodo,
        _tasksDone = tasksDone;

  factory _$_ToDoListData.fromJson(Map<String, dynamic> json) =>
      _$$_ToDoListDataFromJson(json);

  final List<Task> _tasksTodo;
  @override
  @JsonKey()
  List<Task> get tasksTodo {
    if (_tasksTodo is EqualUnmodifiableListView) return _tasksTodo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasksTodo);
  }

  final List<Task> _tasksDone;
  @override
  @JsonKey()
  List<Task> get tasksDone {
    if (_tasksDone is EqualUnmodifiableListView) return _tasksDone;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasksDone);
  }

  @override
  @JsonKey()
  final int length;

  @override
  String toString() {
    return 'ToDoListData(tasksTodo: $tasksTodo, tasksDone: $tasksDone, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToDoListData &&
            const DeepCollectionEquality()
                .equals(other._tasksTodo, _tasksTodo) &&
            const DeepCollectionEquality()
                .equals(other._tasksDone, _tasksDone) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasksTodo),
      const DeepCollectionEquality().hash(_tasksDone),
      length);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ToDoListDataCopyWith<_$_ToDoListData> get copyWith =>
      __$$_ToDoListDataCopyWithImpl<_$_ToDoListData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ToDoListDataToJson(
      this,
    );
  }
}

abstract class _ToDoListData implements ToDoListData {
  factory _ToDoListData(
      [final List<Task> tasksTodo,
      final List<Task> tasksDone,
      final int length]) = _$_ToDoListData;

  factory _ToDoListData.fromJson(Map<String, dynamic> json) =
      _$_ToDoListData.fromJson;

  @override
  List<Task> get tasksTodo;
  @override
  List<Task> get tasksDone;
  @override
  int get length;
  @override
  @JsonKey(ignore: true)
  _$$_ToDoListDataCopyWith<_$_ToDoListData> get copyWith =>
      throw _privateConstructorUsedError;
}

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call({int id, String content});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$_TaskCopyWith(_$_Task value, $Res Function(_$_Task) then) =
      __$$_TaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String content});
}

/// @nodoc
class __$$_TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$_Task>
    implements _$$_TaskCopyWith<$Res> {
  __$$_TaskCopyWithImpl(_$_Task _value, $Res Function(_$_Task) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_$_Task(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Task implements _Task {
  _$_Task(this.id, this.content);

  factory _$_Task.fromJson(Map<String, dynamic> json) => _$$_TaskFromJson(json);

  @override
  final int id;
  @override
  final String content;

  @override
  String toString() {
    return 'Task(id: $id, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Task &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskCopyWith<_$_Task> get copyWith =>
      __$$_TaskCopyWithImpl<_$_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  factory _Task(final int id, final String content) = _$_Task;

  factory _Task.fromJson(Map<String, dynamic> json) = _$_Task.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_TaskCopyWith<_$_Task> get copyWith => throw _privateConstructorUsedError;
}
