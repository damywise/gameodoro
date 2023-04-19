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
    return SessionData(
      data: ref.watch(
        sessionListProvider
            .select((value) => value.firstWhere((element) => element.selected)),
      ),
      elapsed: 0,
      stopwatchState: StopwatchState.stopped,
      studyState: StudyState.focus,
      number: 0,
    );
  }

  Duration duration() {
    switch (state.studyState) {
      case StudyState.focus:
        return state.data.studyDuration;
      case StudyState.shortBreak:
        return state.data.shortBreakDuration;
      case StudyState.longBreak:
        return state.data.longBreakDuration;
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

  void _tick(Timer timer) {
    if (_stopwatch.elapsedMilliseconds + 100 >= duration().inMilliseconds) {
      _stopwatch.reset();
      switch (state.studyState) {
        case StudyState.focus:
          state = state.copyWith(
            studyState: state.number == 4
                ? StudyState.longBreak
                : StudyState.shortBreak,
          );
          break;
        case StudyState.shortBreak:
        case StudyState.longBreak:
          state = state.copyWith(studyState: StudyState.focus);
          break;
      }
      if (state.number >= 4) {
        state = state.copyWith(number: 1);
      } else {
        state = state.copyWith(number: state.number + 1);
      }
      return;
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
    required StudyState studyState,

    /// Number of current session.
    /// 0 if not started at all yet
    required int number,
  }) = _SessionData;
}

enum StopwatchState {
  started,
  stopped,
}

enum StudyState { focus, shortBreak, longBreak }
