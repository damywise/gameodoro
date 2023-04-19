import 'package:collection/collection.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_list.g.dart';

part 'session_list.freezed.dart';

@Riverpod(keepAlive: true)
class SessionList extends _$SessionList {
  @override
  List<SessionModel> build() {
    return [
      const SessionModel(
        name: 'Pomodoro Default',
        studyDuration: Duration(seconds: 10),
        shortBreakDuration: Duration(seconds: 5),
        longBreakDuration: Duration(seconds: 15),
        selected: true,
      )
    ];
  }

  int getIndexFromName(String name) =>
      state.indexWhere((element) => element.name == name);

  int getSelectedIndex() => state.indexWhere((element) => element.selected);

  SessionModel selected() => state.firstWhere((element) => element.selected);

  // void changeSelectedState(SessionState sessionState) {
  //   state[getSelectedIndex()] = selected().copyWith(state: sessionState);
  //   state = [...state];
  // }

  SessionModel? selectSession(String name) {
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
        SessionModel(
          name: name,
          studyDuration: studyDuration,
          shortBreakDuration: shortBreakDuration,
          longBreakDuration: longBreakDuration,
          selected: selected,
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
class SessionModel with _$SessionModel {
  /// Contains custom pomodoro session data:
  /// Session name,
  /// Study duration,
  /// Short break duration, and
  /// Long break duration
  const factory SessionModel({
    required String name,
    required Duration studyDuration,
    required Duration shortBreakDuration,
    required Duration longBreakDuration,
    required bool selected,
  }) = _SessionData;
}
