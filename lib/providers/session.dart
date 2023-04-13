import 'dart:async';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

part 'session.freezed.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  List<SessionData> build() {
    _stopwatch = Stopwatch();
    _stream = StreamController();
    _broadcastStream = _stream!.stream.asBroadcastStream();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _tick);
    return [
      const SessionData(
        name: 'Pomodoro Default',
        studyDuration: Duration(seconds: 10),
        shortBreakDuration: Duration(minutes: 5),
        longBreakDuration: Duration(minutes: 15),
        selected: true,
        state: SessionState.study,
      )
    ];
  }

  StreamController<int>? _stream;
  Stream<int>? _broadcastStream;
  Stopwatch? _stopwatch;
  Timer? _timer;

  StreamController<int> streamController() => _stream!;

  Stream<int> stream() => _broadcastStream!;

  Stopwatch stopwatch() => _stopwatch!;

  int getIndexFromName(String name) =>
      state.indexWhere((element) => element.name == name);

  int getSelectedIndex() => state.indexWhere((element) => element.selected);

  SessionData selected() => state.firstWhere((element) => element.selected);

  Duration duration() {
    switch (selected().state) {
      case SessionState.study:
        return selected().studyDuration;
      case SessionState.shortBreak:
        return selected().shortBreakDuration;
      case SessionState.longBreak:
        return selected().longBreakDuration;
    }
  }

  void _tick(Timer timer) {
    if (_stopwatch!.isRunning) {
      _stream!.add(_stopwatch!.elapsedMilliseconds);
    }
  }

  SessionData? selectSession(String name) {
    state[getSelectedIndex()] =
        state[getSelectedIndex()].copyWith(selected: false);
    final newSession = state
        .firstWhereOrNull((element) => element.name == name)
        ?.copyWith(selected: true);
    if (newSession != null) {
      state[getIndexFromName(newSession.name)] = newSession;
    }
    return newSession;
  }

  bool _isDuplicate(String name) {
    return state.map((e) => e.name).contains(name);
  }

  void addSession({
    required String name,
    required Duration studyDuration,
    required Duration shortBreakDuration,
    required Duration longBreakDuration,
    required bool selected,
  }) {
    if (!_isDuplicate(name)) {
      state.add(
        SessionData(
          name: name,
          studyDuration: studyDuration,
          shortBreakDuration: shortBreakDuration,
          longBreakDuration: longBreakDuration,
          selected: selected,
          state: SessionState.study,
        ),
      );
    }
  }

  void deleteSession(String name) {
    final index = getIndexFromName(name);
    if (index != 0 && index != -1) {
      state.removeAt(index);
    }
  }

  void editSession(
    String name, {
    String? newName,
    Duration? studyDuration,
    Duration? shortBreakDuration,
    Duration? longBreakDuration,
  }) {
    final index = getIndexFromName(name);
    if (index != 0 && index != -1) {
      state[index] = state[index].copyWith(
        name: newName ?? name,
        studyDuration: studyDuration ?? state[index].studyDuration,
        shortBreakDuration:
            shortBreakDuration ?? state[index].shortBreakDuration,
        longBreakDuration: longBreakDuration ?? state[index].longBreakDuration,
      );
    }
  }
}

/// Contains custom pomodoro session data:
/// Session name,
/// Study duration,
/// Short break duration, and
/// Long break duration
@freezed
class SessionData with _$SessionData {
  /// Contains custom pomodoro session data:
  /// Session name,
  /// Study duration,
  /// Short break duration, and
  /// Long break duration
  const factory SessionData({
    required String name,
    required Duration studyDuration,
    required Duration shortBreakDuration,
    required Duration longBreakDuration,
    required bool selected,
    required SessionState state,
  }) = _SessionData;
}

enum SessionState { study, shortBreak, longBreak }
