// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SessionData {
  SessionModel get data => throw _privateConstructorUsedError;
  int get elapsed => throw _privateConstructorUsedError;
  StopwatchState get stopwatchState => throw _privateConstructorUsedError;
  StudyState get studyState => throw _privateConstructorUsedError;

  /// Number of current session.
  /// 0 if not started at all yet
  int get number => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionDataCopyWith<SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionDataCopyWith<$Res> {
  factory $SessionDataCopyWith(
          SessionData value, $Res Function(SessionData) then) =
      _$SessionDataCopyWithImpl<$Res, SessionData>;
  @useResult
  $Res call(
      {SessionModel data,
      int elapsed,
      StopwatchState stopwatchState,
      StudyState studyState,
      int number});

  $SessionModelCopyWith<$Res> get data;
}

/// @nodoc
class _$SessionDataCopyWithImpl<$Res, $Val extends SessionData>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? elapsed = null,
    Object? stopwatchState = null,
    Object? studyState = null,
    Object? number = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SessionModel,
      elapsed: null == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as int,
      stopwatchState: null == stopwatchState
          ? _value.stopwatchState
          : stopwatchState // ignore: cast_nullable_to_non_nullable
              as StopwatchState,
      studyState: null == studyState
          ? _value.studyState
          : studyState // ignore: cast_nullable_to_non_nullable
              as StudyState,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SessionModelCopyWith<$Res> get data {
    return $SessionModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SessionDataCopyWith<$Res>
    implements $SessionDataCopyWith<$Res> {
  factory _$$_SessionDataCopyWith(
          _$_SessionData value, $Res Function(_$_SessionData) then) =
      __$$_SessionDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SessionModel data,
      int elapsed,
      StopwatchState stopwatchState,
      StudyState studyState,
      int number});

  @override
  $SessionModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$_SessionDataCopyWithImpl<$Res>
    extends _$SessionDataCopyWithImpl<$Res, _$_SessionData>
    implements _$$_SessionDataCopyWith<$Res> {
  __$$_SessionDataCopyWithImpl(
      _$_SessionData _value, $Res Function(_$_SessionData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? elapsed = null,
    Object? stopwatchState = null,
    Object? studyState = null,
    Object? number = null,
  }) {
    return _then(_$_SessionData(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SessionModel,
      elapsed: null == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as int,
      stopwatchState: null == stopwatchState
          ? _value.stopwatchState
          : stopwatchState // ignore: cast_nullable_to_non_nullable
              as StopwatchState,
      studyState: null == studyState
          ? _value.studyState
          : studyState // ignore: cast_nullable_to_non_nullable
              as StudyState,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SessionData implements _SessionData {
  const _$_SessionData(
      {required this.data,
      required this.elapsed,
      required this.stopwatchState,
      required this.studyState,
      required this.number});

  @override
  final SessionModel data;
  @override
  final int elapsed;
  @override
  final StopwatchState stopwatchState;
  @override
  final StudyState studyState;

  /// Number of current session.
  /// 0 if not started at all yet
  @override
  final int number;

  @override
  String toString() {
    return 'SessionData(data: $data, elapsed: $elapsed, stopwatchState: $stopwatchState, studyState: $studyState, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionData &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.elapsed, elapsed) || other.elapsed == elapsed) &&
            (identical(other.stopwatchState, stopwatchState) ||
                other.stopwatchState == stopwatchState) &&
            (identical(other.studyState, studyState) ||
                other.studyState == studyState) &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, data, elapsed, stopwatchState, studyState, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      __$$_SessionDataCopyWithImpl<_$_SessionData>(this, _$identity);
}

abstract class _SessionData implements SessionData {
  const factory _SessionData(
      {required final SessionModel data,
      required final int elapsed,
      required final StopwatchState stopwatchState,
      required final StudyState studyState,
      required final int number}) = _$_SessionData;

  @override
  SessionModel get data;
  @override
  int get elapsed;
  @override
  StopwatchState get stopwatchState;
  @override
  StudyState get studyState;
  @override

  /// Number of current session.
  /// 0 if not started at all yet
  int get number;
  @override
  @JsonKey(ignore: true)
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}
