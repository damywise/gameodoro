// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tune.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TuneData _$TuneDataFromJson(Map<String, dynamic> json) {
  return _TuneData.fromJson(json);
}

/// @nodoc
mixin _$TuneData {
  String get title => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TuneDataCopyWith<TuneData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TuneDataCopyWith<$Res> {
  factory $TuneDataCopyWith(TuneData value, $Res Function(TuneData) then) =
      _$TuneDataCopyWithImpl<$Res, TuneData>;
  @useResult
  $Res call({String title, String path, bool selected});
}

/// @nodoc
class _$TuneDataCopyWithImpl<$Res, $Val extends TuneData>
    implements $TuneDataCopyWith<$Res> {
  _$TuneDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? path = null,
    Object? selected = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TuneDataCopyWith<$Res> implements $TuneDataCopyWith<$Res> {
  factory _$$_TuneDataCopyWith(
          _$_TuneData value, $Res Function(_$_TuneData) then) =
      __$$_TuneDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String path, bool selected});
}

/// @nodoc
class __$$_TuneDataCopyWithImpl<$Res>
    extends _$TuneDataCopyWithImpl<$Res, _$_TuneData>
    implements _$$_TuneDataCopyWith<$Res> {
  __$$_TuneDataCopyWithImpl(
      _$_TuneData _value, $Res Function(_$_TuneData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? path = null,
    Object? selected = null,
  }) {
    return _then(_$_TuneData(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TuneData implements _TuneData {
  const _$_TuneData(
      {required this.title, required this.path, this.selected = false});

  factory _$_TuneData.fromJson(Map<String, dynamic> json) =>
      _$$_TuneDataFromJson(json);

  @override
  final String title;
  @override
  final String path;
  @override
  @JsonKey()
  final bool selected;

  @override
  String toString() {
    return 'TuneData(title: $title, path: $path, selected: $selected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TuneData &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, path, selected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TuneDataCopyWith<_$_TuneData> get copyWith =>
      __$$_TuneDataCopyWithImpl<_$_TuneData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TuneDataToJson(
      this,
    );
  }
}

abstract class _TuneData implements TuneData {
  const factory _TuneData(
      {required final String title,
      required final String path,
      final bool selected}) = _$_TuneData;

  factory _TuneData.fromJson(Map<String, dynamic> json) = _$_TuneData.fromJson;

  @override
  String get title;
  @override
  String get path;
  @override
  bool get selected;
  @override
  @JsonKey(ignore: true)
  _$$_TuneDataCopyWith<_$_TuneData> get copyWith =>
      throw _privateConstructorUsedError;
}
