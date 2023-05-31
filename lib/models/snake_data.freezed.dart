// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snake_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SnakeData _$SnakeDataFromJson(Map<String, dynamic> json) {
  return _SnakeData.fromJson(json);
}

/// @nodoc
mixin _$SnakeData {
  List<List<int>> get level => throw _privateConstructorUsedError;
  List<SnakePos> get pos => throw _privateConstructorUsedError;
  AxisDirection get direction => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get isGameover => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SnakeDataCopyWith<SnakeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnakeDataCopyWith<$Res> {
  factory $SnakeDataCopyWith(SnakeData value, $Res Function(SnakeData) then) =
      _$SnakeDataCopyWithImpl<$Res, SnakeData>;
  @useResult
  $Res call(
      {List<List<int>> level,
      List<SnakePos> pos,
      AxisDirection direction,
      bool isPlaying,
      bool isPaused,
      bool isGameover});
}

/// @nodoc
class _$SnakeDataCopyWithImpl<$Res, $Val extends SnakeData>
    implements $SnakeDataCopyWith<$Res> {
  _$SnakeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? pos = null,
    Object? direction = null,
    Object? isPlaying = null,
    Object? isPaused = null,
    Object? isGameover = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as List<SnakePos>,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as AxisDirection,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isGameover: null == isGameover
          ? _value.isGameover
          : isGameover // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SnakeDataCopyWith<$Res> implements $SnakeDataCopyWith<$Res> {
  factory _$$_SnakeDataCopyWith(
          _$_SnakeData value, $Res Function(_$_SnakeData) then) =
      __$$_SnakeDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<int>> level,
      List<SnakePos> pos,
      AxisDirection direction,
      bool isPlaying,
      bool isPaused,
      bool isGameover});
}

/// @nodoc
class __$$_SnakeDataCopyWithImpl<$Res>
    extends _$SnakeDataCopyWithImpl<$Res, _$_SnakeData>
    implements _$$_SnakeDataCopyWith<$Res> {
  __$$_SnakeDataCopyWithImpl(
      _$_SnakeData _value, $Res Function(_$_SnakeData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? pos = null,
    Object? direction = null,
    Object? isPlaying = null,
    Object? isPaused = null,
    Object? isGameover = null,
  }) {
    return _then(_$_SnakeData(
      level: null == level
          ? _value._level
          : level // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      pos: null == pos
          ? _value._pos
          : pos // ignore: cast_nullable_to_non_nullable
              as List<SnakePos>,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as AxisDirection,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isGameover: null == isGameover
          ? _value.isGameover
          : isGameover // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SnakeData implements _SnakeData {
  const _$_SnakeData(
      {required final List<List<int>> level,
      required final List<SnakePos> pos,
      required this.direction,
      required this.isPlaying,
      required this.isPaused,
      required this.isGameover})
      : _level = level,
        _pos = pos;

  factory _$_SnakeData.fromJson(Map<String, dynamic> json) =>
      _$$_SnakeDataFromJson(json);

  final List<List<int>> _level;
  @override
  List<List<int>> get level {
    if (_level is EqualUnmodifiableListView) return _level;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_level);
  }

  final List<SnakePos> _pos;
  @override
  List<SnakePos> get pos {
    if (_pos is EqualUnmodifiableListView) return _pos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pos);
  }

  @override
  final AxisDirection direction;
  @override
  final bool isPlaying;
  @override
  final bool isPaused;
  @override
  final bool isGameover;

  @override
  String toString() {
    return 'SnakeData(level: $level, pos: $pos, direction: $direction, isPlaying: $isPlaying, isPaused: $isPaused, isGameover: $isGameover)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SnakeData &&
            const DeepCollectionEquality().equals(other._level, _level) &&
            const DeepCollectionEquality().equals(other._pos, _pos) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.isGameover, isGameover) ||
                other.isGameover == isGameover));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_level),
      const DeepCollectionEquality().hash(_pos),
      direction,
      isPlaying,
      isPaused,
      isGameover);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SnakeDataCopyWith<_$_SnakeData> get copyWith =>
      __$$_SnakeDataCopyWithImpl<_$_SnakeData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SnakeDataToJson(
      this,
    );
  }
}

abstract class _SnakeData implements SnakeData {
  const factory _SnakeData(
      {required final List<List<int>> level,
      required final List<SnakePos> pos,
      required final AxisDirection direction,
      required final bool isPlaying,
      required final bool isPaused,
      required final bool isGameover}) = _$_SnakeData;

  factory _SnakeData.fromJson(Map<String, dynamic> json) =
      _$_SnakeData.fromJson;

  @override
  List<List<int>> get level;
  @override
  List<SnakePos> get pos;
  @override
  AxisDirection get direction;
  @override
  bool get isPlaying;
  @override
  bool get isPaused;
  @override
  bool get isGameover;
  @override
  @JsonKey(ignore: true)
  _$$_SnakeDataCopyWith<_$_SnakeData> get copyWith =>
      throw _privateConstructorUsedError;
}
