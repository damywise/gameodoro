import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_do_list_data.freezed.dart';

part 'to_do_list_data.g.dart';

@freezed
class ToDoListData with _$ToDoListData {
  factory ToDoListData(
      [@Default([]) List<Task> tasks, @Default(0) int length]) = _ToDoListData;

  factory ToDoListData.fromJson(Map<String, dynamic> json) =>
      _$ToDoListDataFromJson(json);
}

@freezed
class Task with _$Task {
  factory Task(
    int id,
    String content, {
    @Default(false) bool done,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
