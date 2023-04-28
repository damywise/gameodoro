import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:gameodoro/models/to_do_list_data.dart';
import 'package:gameodoro/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'to_do_list.g.dart';

@riverpod
class ToDoList extends _$ToDoList {
  @override
  ToDoListData build() {
    _prefs = ref.read(sharedPreferences);
    final dataRaw = _prefs.getString('todolist');
    final data = ToDoListData.fromJson(
      json.decode(dataRaw ?? '{}') as Map<String, dynamic>,
    );

    return data;
  }

  late SharedPreferences _prefs;

  void add() {
    final newLength = state.length + 1;
    state = state.copyWith(
      tasksTodo: [
        Task(newLength, ''),
        ...state.tasksTodo,
      ],
      length: newLength,
    );
    save();
  }

  void remove(int id) {
    final newTasks = [...state.tasksTodo]
      ..removeWhere((element) => element.id == id);
    final newDone = [...state.tasksDone]
      ..removeWhere((element) => element.id == id);
    state = state.copyWith(tasksTodo: newTasks, tasksDone: newDone);
    save();
  }

  void reorderTodo(int oldIndex, int newIndex) {
    final newTasks = [...state.tasksTodo];
    newTasks.insert(
      newIndex > oldIndex ? newIndex - 1 : newIndex,
      newTasks.removeAt(oldIndex),
    );

    state = state.copyWith(tasksTodo: newTasks);
    save();
  }

  void reorderDone(int oldIndex, int newIndex) {
    final newTasks = [...state.tasksDone];
    newTasks.insert(
      newIndex > oldIndex ? newIndex - 1 : newIndex,
      newTasks.removeAt(oldIndex),
    );

    state = state.copyWith(tasksDone: newTasks);
    save();
  }

  void toggle(int id) {
    final newTasks = [...state.tasksTodo];
    final newDone = [...state.tasksDone];
    final taskTodo = newTasks.firstWhereOrNull((element) => element.id == id);
    final taskDone = newDone.firstWhereOrNull((element) => element.id == id);
    if (taskTodo != null) {
      newTasks.remove(taskTodo);
      newDone.add(taskTodo);
    } else if (taskDone != null) {
      newDone.remove(taskDone);
      newTasks.add(taskDone);
    }
    state = state.copyWith(tasksTodo: newTasks, tasksDone: newDone);
    save();
  }

  void edit(int id, String? content) {
    final newTasksTodo = [...state.tasksTodo];
    final newTasksDone = [...state.tasksDone];
    if (content != null) {
      final indexTodo = newTasksTodo.indexWhere((element) => element.id == id);
      final indexDone = newTasksDone.indexWhere((element) => element.id == id);
      if (indexTodo > -1) {
        newTasksTodo[indexTodo] =
            newTasksTodo[indexTodo].copyWith(content: content);
      }
      if (indexDone > -1) {
        newTasksDone[indexDone] =
            newTasksDone[indexDone].copyWith(content: content);
      }
    }
    state = state.copyWith(tasksTodo: newTasksTodo, tasksDone: newTasksDone);
    save();
  }

  void save() {
    _prefs.setString('todolist', json.encode(state.toJson()));
  }
}
