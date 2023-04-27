// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tune.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TuneData _$$_TuneDataFromJson(Map<String, dynamic> json) => _$_TuneData(
      title: json['title'] as String,
      path: json['path'] as String,
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TuneDataToJson(_$_TuneData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'path': instance.path,
      'selected': instance.selected,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tuneHash() => r'7ac8c3454924d1639456f383b86c34861bd22b4c';

/// See also [Tune].
@ProviderFor(Tune)
final tuneProvider = AutoDisposeNotifierProvider<Tune, List<TuneData>>.internal(
  Tune.new,
  name: r'tuneProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tuneHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Tune = AutoDisposeNotifier<List<TuneData>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
