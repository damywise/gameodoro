import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameodoro/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session.g.dart';

part 'session.freezed.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  SessionData build() {
    _stopwatch = Stopwatch();
    Timer.periodic(const Duration(milliseconds: 100), _tick);
    _prefs = ref.read(sharedPreferences);
    final dataRaw = _prefs.getString('sessionData');
    final data = SessionModel.fromJson(
      json.decode(dataRaw ?? '{}') as Map<String, dynamic>,
    );
    final duration = data.studyDuration;
    return SessionData(
      data: data,
      elapsed: 0,
      stopwatchState: StopwatchState.stopped,
      sessionState: SessionState.focus,
      number: 0,
      duration: duration,
    );
  }

  late SharedPreferences _prefs;

  void _updateDuration() {
    switch (state.sessionState) {
      case SessionState.focus:
        state = state.copyWith(duration: state.data.studyDuration);
        break;
      case SessionState.shortBreak:
        state = state.copyWith(duration: state.data.shortBreakDuration);
        break;
      case SessionState.longBreak:
        state = state.copyWith(duration: state.data.longBreakDuration);
        break;
    }
  }

  late Stopwatch _stopwatch;

  void start() {
    state = state.copyWith(stopwatchState: StopwatchState.started, number: 1);
    _stopwatch.start();
  }

  void pause() {
    state = state.copyWith(stopwatchState: StopwatchState.stopped);
    _stopwatch.stop();
  }

  void finish() {
    state = state.copyWith(stopwatchState: StopwatchState.started, number: 0);
    _stopwatch.stop();
  }

  void edit({
    Duration? studyDuration,
    Duration? shortBreakDuration,
    Duration? longBreakDuration,
  }) {
    final data = state.data;
    final newData = data.copyWith(
      studyDuration: studyDuration ?? data.studyDuration,
      shortBreakDuration: shortBreakDuration ?? data.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? data.longBreakDuration,
    );
    state = state.copyWith(data: newData);
    _updateStudyState();
    saveData();
  }

  void next() {
    if (state.number >= 4) {
      state = state.copyWith(number: 1);
    } else if (state.number == 0) {
      state = state.copyWith(number: 2);
    } else {
      state = state.copyWith(number: state.number + 1);
    }
    _updateStudyState();
  }

  void previous() {
    if (state.number <= 1) {
      state = state.copyWith(number: 4);
    } else {
      state = state.copyWith(number: state.number - 1);
    }
    _updateStudyState();
  }

  void _updateStudyState() {
    _stopwatch.reset();
    switch (state.sessionState) {
      case SessionState.focus:
        state = state.copyWith(
          sessionState:
              state.number == 4 ? SessionState.longBreak : SessionState.shortBreak,
          elapsed: 0,
        );
        break;
      case SessionState.shortBreak:
      case SessionState.longBreak:
        state = state.copyWith(sessionState: SessionState.focus, elapsed: 0);
        break;
    }
    _updateDuration();
  }

  void _tick(Timer timer) {
    final isSessionDone =
        _stopwatch.elapsedMilliseconds + 100 >= state.duration.inMilliseconds;
    if (isSessionDone) {
      return next();
    }
    if (_stopwatch.isRunning) {
      state = state.copyWith(elapsed: _stopwatch.elapsedMilliseconds);
    }
  }

  void saveData() {
    _prefs.setString('sessionData', json.encode(state.data.toJson()));
  }
}

@freezed
class SessionData with _$SessionData {
  const factory SessionData({
    required SessionModel data,

    /// Milliseconds elapsed since the session started
    required int elapsed,
    required StopwatchState stopwatchState,
    required SessionState sessionState,
    required Duration duration,

    /// Number of current session.
    /// 0 if not yet started any session
    required int number,
  }) = _SessionData;

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);
}

enum StopwatchState {
  started,
  stopped,
}

enum SessionState { focus, shortBreak, longBreak }

/// Contains custom pomodoro session data:
/// Session name,
/// Study duration,
/// Short break duration, and
/// Long break duration
@freezed
class SessionModel with _$SessionModel {
  /// Contains custom pomodoro session data:
  /// Session name,
  /// Study duration,
  /// Short break duration, and
  /// Long break duration
  const factory SessionModel({
    @Default(Duration(minutes: 25)) Duration studyDuration,
    @Default(Duration(minutes: 5)) Duration shortBreakDuration,
    @Default(Duration(minutes: 15)) Duration longBreakDuration,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}
