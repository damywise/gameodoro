// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SessionModel {
  String get name => throw _privateConstructorUsedError;
  Duration get studyDuration => throw _privateConstructorUsedError;
  Duration get shortBreakDuration => throw _privateConstructorUsedError;
  Duration get longBreakDuration => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionModelCopyWith<SessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionModelCopyWith<$Res> {
  factory $SessionModelCopyWith(
          SessionModel value, $Res Function(SessionModel) then) =
      _$SessionModelCopyWithImpl<$Res, SessionModel>;
  @useResult
  $Res call(
      {String name,
      Duration studyDuration,
      Duration shortBreakDuration,
      Duration longBreakDuration,
      bool selected});
}

/// @nodoc
class _$SessionModelCopyWithImpl<$Res, $Val extends SessionModel>
    implements $SessionModelCopyWith<$Res> {
  _$SessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? studyDuration = null,
    Object? shortBreakDuration = null,
    Object? longBreakDuration = null,
    Object? selected = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      studyDuration: null == studyDuration
          ? _value.studyDuration
          : studyDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      shortBreakDuration: null == shortBreakDuration
          ? _value.shortBreakDuration
          : shortBreakDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      longBreakDuration: null == longBreakDuration
          ? _value.longBreakDuration
          : longBreakDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionDataCopyWith<$Res>
    implements $SessionModelCopyWith<$Res> {
  factory _$$_SessionDataCopyWith(
          _$_SessionData value, $Res Function(_$_SessionData) then) =
      __$$_SessionDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Duration studyDuration,
      Duration shortBreakDuration,
      Duration longBreakDuration,
      bool selected});
}

/// @nodoc
class __$$_SessionDataCopyWithImpl<$Res>
    extends _$SessionModelCopyWithImpl<$Res, _$_SessionData>
    implements _$$_SessionDataCopyWith<$Res> {
  __$$_SessionDataCopyWithImpl(
      _$_SessionData _value, $Res Function(_$_SessionData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? studyDuration = null,
    Object? shortBreakDuration = null,
    Object? longBreakDuration = null,
    Object? selected = null,
  }) {
    return _then(_$_SessionData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      studyDuration: null == studyDuration
          ? _value.studyDuration
          : studyDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      shortBreakDuration: null == shortBreakDuration
          ? _value.shortBreakDuration
          : shortBreakDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      longBreakDuration: null == longBreakDuration
          ? _value.longBreakDuration
          : longBreakDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SessionData implements _SessionData {
  const _$_SessionData(
      {required this.name,
      required this.studyDuration,
      required this.shortBreakDuration,
      required this.longBreakDuration,
      required this.selected});

  @override
  final String name;
  @override
  final Duration studyDuration;
  @override
  final Duration shortBreakDuration;
  @override
  final Duration longBreakDuration;
  @override
  final bool selected;

  @override
  String toString() {
    return 'SessionModel(name: $name, studyDuration: $studyDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, selected: $selected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.studyDuration, studyDuration) ||
                other.studyDuration == studyDuration) &&
            (identical(other.shortBreakDuration, shortBreakDuration) ||
                other.shortBreakDuration == shortBreakDuration) &&
            (identical(other.longBreakDuration, longBreakDuration) ||
                other.longBreakDuration == longBreakDuration) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, studyDuration,
      shortBreakDuration, longBreakDuration, selected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      __$$_SessionDataCopyWithImpl<_$_SessionData>(this, _$identity);
}

abstract class _SessionData implements SessionModel {
  const factory _SessionData(
      {required final String name,
      required final Duration studyDuration,
      required final Duration shortBreakDuration,
      required final Duration longBreakDuration,
      required final bool selected}) = _$_SessionData;

  @override
  String get name;
  @override
  Duration get studyDuration;
  @override
  Duration get shortBreakDuration;
  @override
  Duration get longBreakDuration;
  @override
  bool get selected;
  @override
  @JsonKey(ignore: true)
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}
