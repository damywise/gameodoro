// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tetris_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TetrisData _$TetrisDataFromJson(Map<String, dynamic> json) {
  return _TetrisData.fromJson(json);
}

/// @nodoc
mixin _$TetrisData {
  List<List<int>> get level => throw _privateConstructorUsedError;
  Block? get currentBlock => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get isGameover => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TetrisDataCopyWith<TetrisData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TetrisDataCopyWith<$Res> {
  factory $TetrisDataCopyWith(
          TetrisData value, $Res Function(TetrisData) then) =
      _$TetrisDataCopyWithImpl<$Res, TetrisData>;
  @useResult
  $Res call(
      {List<List<int>> level,
      Block? currentBlock,
      bool isPlaying,
      bool isPaused,
      bool isGameover});

  $BlockCopyWith<$Res>? get currentBlock;
}

/// @nodoc
class _$TetrisDataCopyWithImpl<$Res, $Val extends TetrisData>
    implements $TetrisDataCopyWith<$Res> {
  _$TetrisDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? currentBlock = freezed,
    Object? isPlaying = null,
    Object? isPaused = null,
    Object? isGameover = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      currentBlock: freezed == currentBlock
          ? _value.currentBlock
          : currentBlock // ignore: cast_nullable_to_non_nullable
              as Block?,
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

  @override
  @pragma('vm:prefer-inline')
  $BlockCopyWith<$Res>? get currentBlock {
    if (_value.currentBlock == null) {
      return null;
    }

    return $BlockCopyWith<$Res>(_value.currentBlock!, (value) {
      return _then(_value.copyWith(currentBlock: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TetrisDataCopyWith<$Res>
    implements $TetrisDataCopyWith<$Res> {
  factory _$$_TetrisDataCopyWith(
          _$_TetrisData value, $Res Function(_$_TetrisData) then) =
      __$$_TetrisDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<int>> level,
      Block? currentBlock,
      bool isPlaying,
      bool isPaused,
      bool isGameover});

  @override
  $BlockCopyWith<$Res>? get currentBlock;
}

/// @nodoc
class __$$_TetrisDataCopyWithImpl<$Res>
    extends _$TetrisDataCopyWithImpl<$Res, _$_TetrisData>
    implements _$$_TetrisDataCopyWith<$Res> {
  __$$_TetrisDataCopyWithImpl(
      _$_TetrisData _value, $Res Function(_$_TetrisData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? currentBlock = freezed,
    Object? isPlaying = null,
    Object? isPaused = null,
    Object? isGameover = null,
  }) {
    return _then(_$_TetrisData(
      level: null == level
          ? _value._level
          : level // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      currentBlock: freezed == currentBlock
          ? _value.currentBlock
          : currentBlock // ignore: cast_nullable_to_non_nullable
              as Block?,
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
class _$_TetrisData implements _TetrisData {
  const _$_TetrisData(
      {required final List<List<int>> level,
      required this.currentBlock,
      required this.isPlaying,
      required this.isPaused,
      required this.isGameover})
      : _level = level;

  factory _$_TetrisData.fromJson(Map<String, dynamic> json) =>
      _$$_TetrisDataFromJson(json);

  final List<List<int>> _level;
  @override
  List<List<int>> get level {
    if (_level is EqualUnmodifiableListView) return _level;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_level);
  }

  @override
  final Block? currentBlock;
  @override
  final bool isPlaying;
  @override
  final bool isPaused;
  @override
  final bool isGameover;

  @override
  String toString() {
    return 'TetrisData(level: $level, currentBlock: $currentBlock, isPlaying: $isPlaying, isPaused: $isPaused, isGameover: $isGameover)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TetrisData &&
            const DeepCollectionEquality().equals(other._level, _level) &&
            (identical(other.currentBlock, currentBlock) ||
                other.currentBlock == currentBlock) &&
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
      currentBlock,
      isPlaying,
      isPaused,
      isGameover);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TetrisDataCopyWith<_$_TetrisData> get copyWith =>
      __$$_TetrisDataCopyWithImpl<_$_TetrisData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TetrisDataToJson(
      this,
    );
  }
}

abstract class _TetrisData implements TetrisData {
  const factory _TetrisData(
      {required final List<List<int>> level,
      required final Block? currentBlock,
      required final bool isPlaying,
      required final bool isPaused,
      required final bool isGameover}) = _$_TetrisData;

  factory _TetrisData.fromJson(Map<String, dynamic> json) =
      _$_TetrisData.fromJson;

  @override
  List<List<int>> get level;
  @override
  Block? get currentBlock;
  @override
  bool get isPlaying;
  @override
  bool get isPaused;
  @override
  bool get isGameover;
  @override
  @JsonKey(ignore: true)
  _$$_TetrisDataCopyWith<_$_TetrisData> get copyWith =>
      throw _privateConstructorUsedError;
}
