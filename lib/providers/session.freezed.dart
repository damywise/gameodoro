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

SessionData _$SessionDataFromJson(Map<String, dynamic> json) {
  return _SessionData.fromJson(json);
}

/// @nodoc
mixin _$SessionData {
  SessionModel get data => throw _privateConstructorUsedError;

  /// Milliseconds elapsed since the session started
  int get elapsed => throw _privateConstructorUsedError;
  StopwatchState get stopwatchState => throw _privateConstructorUsedError;
  StudyState get sessionState => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  /// Number of current session.
  /// 0 if not yet started any session
  int get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      StudyState sessionState,
      Duration duration,
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
    Object? sessionState = null,
    Object? duration = null,
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
      sessionState: null == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as StudyState,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
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
      StudyState sessionState,
      Duration duration,
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
    Object? sessionState = null,
    Object? duration = null,
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
      sessionState: null == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as StudyState,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SessionData implements _SessionData {
  const _$_SessionData(
      {required this.data,
      required this.elapsed,
      required this.stopwatchState,
      required this.sessionState,
      required this.duration,
      required this.number});

  factory _$_SessionData.fromJson(Map<String, dynamic> json) =>
      _$$_SessionDataFromJson(json);

  @override
  final SessionModel data;

  /// Milliseconds elapsed since the session started
  @override
  final int elapsed;
  @override
  final StopwatchState stopwatchState;
  @override
  final StudyState sessionState;
  @override
  final Duration duration;

  /// Number of current session.
  /// 0 if not yet started any session
  @override
  final int number;

  @override
  String toString() {
    return 'SessionData(data: $data, elapsed: $elapsed, stopwatchState: $stopwatchState, sessionState: $sessionState, duration: $duration, number: $number)';
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
            (identical(other.sessionState, sessionState) ||
                other.sessionState == sessionState) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, elapsed, stopwatchState,
      sessionState, duration, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      __$$_SessionDataCopyWithImpl<_$_SessionData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionDataToJson(
      this,
    );
  }
}

abstract class _SessionData implements SessionData {
  const factory _SessionData(
      {required final SessionModel data,
      required final int elapsed,
      required final StopwatchState stopwatchState,
      required final StudyState sessionState,
      required final Duration duration,
      required final int number}) = _$_SessionData;

  factory _SessionData.fromJson(Map<String, dynamic> json) =
      _$_SessionData.fromJson;

  @override
  SessionModel get data;
  @override

  /// Milliseconds elapsed since the session started
  int get elapsed;
  @override
  StopwatchState get stopwatchState;
  @override
  StudyState get sessionState;
  @override
  Duration get duration;
  @override

  /// Number of current session.
  /// 0 if not yet started any session
  int get number;
  @override
  @JsonKey(ignore: true)
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) {
  return _SessionModel.fromJson(json);
}

/// @nodoc
mixin _$SessionModel {
  Duration get studyDuration => throw _privateConstructorUsedError;
  Duration get shortBreakDuration => throw _privateConstructorUsedError;
  Duration get longBreakDuration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {Duration studyDuration,
      Duration shortBreakDuration,
      Duration longBreakDuration});
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
    Object? studyDuration = null,
    Object? shortBreakDuration = null,
    Object? longBreakDuration = null,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionModelCopyWith<$Res>
    implements $SessionModelCopyWith<$Res> {
  factory _$$_SessionModelCopyWith(
          _$_SessionModel value, $Res Function(_$_SessionModel) then) =
      __$$_SessionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration studyDuration,
      Duration shortBreakDuration,
      Duration longBreakDuration});
}

/// @nodoc
class __$$_SessionModelCopyWithImpl<$Res>
    extends _$SessionModelCopyWithImpl<$Res, _$_SessionModel>
    implements _$$_SessionModelCopyWith<$Res> {
  __$$_SessionModelCopyWithImpl(
      _$_SessionModel _value, $Res Function(_$_SessionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyDuration = null,
    Object? shortBreakDuration = null,
    Object? longBreakDuration = null,
  }) {
    return _then(_$_SessionModel(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SessionModel implements _SessionModel {
  const _$_SessionModel(
      {this.studyDuration = const Duration(minutes: 25),
      this.shortBreakDuration = const Duration(minutes: 5),
      this.longBreakDuration = const Duration(minutes: 15)});

  factory _$_SessionModel.fromJson(Map<String, dynamic> json) =>
      _$$_SessionModelFromJson(json);

  @override
  @JsonKey()
  final Duration studyDuration;
  @override
  @JsonKey()
  final Duration shortBreakDuration;
  @override
  @JsonKey()
  final Duration longBreakDuration;

  @override
  String toString() {
    return 'SessionModel(studyDuration: $studyDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionModel &&
            (identical(other.studyDuration, studyDuration) ||
                other.studyDuration == studyDuration) &&
            (identical(other.shortBreakDuration, shortBreakDuration) ||
                other.shortBreakDuration == shortBreakDuration) &&
            (identical(other.longBreakDuration, longBreakDuration) ||
                other.longBreakDuration == longBreakDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, studyDuration, shortBreakDuration, longBreakDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionModelCopyWith<_$_SessionModel> get copyWith =>
      __$$_SessionModelCopyWithImpl<_$_SessionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionModelToJson(
      this,
    );
  }
}

abstract class _SessionModel implements SessionModel {
  const factory _SessionModel(
      {final Duration studyDuration,
      final Duration shortBreakDuration,
      final Duration longBreakDuration}) = _$_SessionModel;

  factory _SessionModel.fromJson(Map<String, dynamic> json) =
      _$_SessionModel.fromJson;

  @override
  Duration get studyDuration;
  @override
  Duration get shortBreakDuration;
  @override
  Duration get longBreakDuration;
  @override
  @JsonKey(ignore: true)
  _$$_SessionModelCopyWith<_$_SessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
