import 'dart:convert';

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
      tasks: [...state.tasks, Task(newLength, '')],
      length: newLength,
    );
    save();
  }

  void remove(int id) {
    final newTasks = [...state.tasks]
      ..removeWhere((element) => element.id == id);
    state = state.copyWith(tasks: newTasks);
    save();
  }

  void reorder(int oldIndex, int newIndex) {
    final newTasks = [...state.tasks];
    newTasks.insert(
      newIndex > oldIndex ? newIndex - 1 : newIndex,
      newTasks.removeAt(oldIndex),
    );

    state = state.copyWith(tasks: newTasks);
    save();
  }

  void edit(int id, {String? content, bool? done}) {
    final newTasks = [...state.tasks];
    final index = newTasks.indexWhere((element) => element.id == id);
    final task = newTasks[index];
    final newTask = task.copyWith(
      content: content ?? task.content,
      done: done ?? task.done,
    );
    newTasks[index] = newTask;
    state = state.copyWith(tasks: newTasks);
    save();
  }

  void save() {
    _prefs.setString('todolist', json.encode(state.toJson()));
  }
}
