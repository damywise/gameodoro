// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionData _$$_SessionDataFromJson(Map<String, dynamic> json) =>
    _$_SessionData(
      data: SessionModel.fromJson(json['data'] as Map<String, dynamic>),
      elapsed: json['elapsed'] as int,
      stopwatchState:
          $enumDecode(_$StopwatchStateEnumMap, json['stopwatchState']),
      sessionState: $enumDecode(_$StudyStateEnumMap, json['sessionState']),
      duration: Duration(microseconds: json['duration'] as int),
      number: json['number'] as int,
    );

Map<String, dynamic> _$$_SessionDataToJson(_$_SessionData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'elapsed': instance.elapsed,
      'stopwatchState': _$StopwatchStateEnumMap[instance.stopwatchState]!,
      'sessionState': _$StudyStateEnumMap[instance.sessionState]!,
      'duration': instance.duration.inMicroseconds,
      'number': instance.number,
    };

const _$StopwatchStateEnumMap = {
  StopwatchState.started: 'started',
  StopwatchState.stopped: 'stopped',
};

const _$StudyStateEnumMap = {
  StudyState.focus: 'focus',
  StudyState.shortBreak: 'shortBreak',
  StudyState.longBreak: 'longBreak',
};

_$_SessionModel _$$_SessionModelFromJson(Map<String, dynamic> json) =>
    _$_SessionModel(
      studyDuration: json['studyDuration'] == null
          ? const Duration(minutes: 25)
          : Duration(microseconds: json['studyDuration'] as int),
      shortBreakDuration: json['shortBreakDuration'] == null
          ? const Duration(minutes: 5)
          : Duration(microseconds: json['shortBreakDuration'] as int),
      longBreakDuration: json['longBreakDuration'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: json['longBreakDuration'] as int),
    );

Map<String, dynamic> _$$_SessionModelToJson(_$_SessionModel instance) =>
    <String, dynamic>{
      'studyDuration': instance.studyDuration.inMicroseconds,
      'shortBreakDuration': instance.shortBreakDuration.inMicroseconds,
      'longBreakDuration': instance.longBreakDuration.inMicroseconds,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionHash() => r'aed8eba2d5d9fba0748a6a9102b2715fc4c24a8e';

/// See also [Session].
@ProviderFor(Session)
final sessionProvider = NotifierProvider<Session, SessionData>.internal(
  Session.new,
  name: r'sessionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Session = Notifier<SessionData>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
