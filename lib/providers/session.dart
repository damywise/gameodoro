import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameodoro/providers/session_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

part 'session.freezed.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  SessionData build() {
    _stopwatch = Stopwatch();
    Timer.periodic(const Duration(milliseconds: 100), _tick);
    final data = ref.watch(
      sessionListProvider
          .select((value) => value.firstWhere((element) => element.selected)),
    );
    final duration = data.studyDuration;
    return SessionData(
      data: data,
      elapsed: 0,
      stopwatchState: StopwatchState.stopped,
      sessionState: StudyState.focus,
      number: 0,
      duration: duration,
    );
  }

  void _updateDuration() {
    switch (state.sessionState) {
      case StudyState.focus:
        state = state.copyWith(duration: state.data.studyDuration);
        break;
      case StudyState.shortBreak:
        state = state.copyWith(duration: state.data.shortBreakDuration);
        break;
      case StudyState.longBreak:
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
      case StudyState.focus:
        state = state.copyWith(
          sessionState:
              state.number == 4 ? StudyState.longBreak : StudyState.shortBreak,
          elapsed: 0,
        );
        break;
      case StudyState.shortBreak:
      case StudyState.longBreak:
        state = state.copyWith(sessionState: StudyState.focus, elapsed: 0);
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
}

@freezed
class SessionData with _$SessionData {
  const factory SessionData({
    required SessionModel data,

    /// Milliseconds elapsed since the session started
    required int elapsed,
    required StopwatchState stopwatchState,
    required StudyState sessionState,
    required Duration duration,

    /// Number of current session.
    /// 0 if not yet started any session
    required int number,
  }) = _SessionData;
}

enum StopwatchState {
  started,
  stopped,
}

enum StudyState { focus, shortBreak, longBreak }
