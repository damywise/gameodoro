import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/models/to_do_list_data.dart';
import 'package:gameodoro/providers/to_do_list.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToDoListPage extends HookConsumerWidget {
  const ToDoListPage({super.key});

  static const route = '/todolist';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksTodo =
        ref.watch(toDoListProvider.select((value) => value.tasksTodo));
    final controllersTodo = useMemoized(
      () => tasksTodo
          .map(
            (e) => TextEditingController(text: e.content),
          )
          .toList(),
      [tasksTodo],
    );

    final tasksDone =
        ref.watch(toDoListProvider.select((value) => value.tasksDone));
    final controllersDone = useMemoized(
      () => tasksDone
          .map(
            (e) => TextEditingController(text: e.content),
          )
          .toList(),
      [tasksDone],
    );

    final todoScrollController = useScrollController();

    final taskNotifier = ref.watch(toDoListProvider.notifier);

    final tabController = useTabController(initialLength: 2);
    final isGoingToFirstTab = useState(false);

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('To Do List'),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary,
            onPressed: () {
              if (isGoingToFirstTab.value == false) {
                todoScrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
                taskNotifier.add();
              }

              Future(() async {
                isGoingToFirstTab.value = true;
                while ((tabController.animation?.value ?? 0) > 0) {
                  print('test');
                  tabController.animateTo(0);
                  await Future<void>.delayed(const Duration(milliseconds: 200));
                }
                isGoingToFirstTab.value = false;
              });
            },
            child: Tooltip(
              message: 'Add task',
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          body: Column(
            children: [
              TabBar(
                tabs: const [
                  Text('Ongoing'),
                  Text('Finished'),
                ],
                controller: tabController,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    (
                      tasksTodo,
                      controllersTodo,
                      taskNotifier.reorderTodo,
                      false
                    ),
                    (
                      tasksDone,
                      controllersDone,
                      taskNotifier.reorderDone,
                      true
                    ),
                  ].map<Widget>(
                    (element) {
                      final (tasks, controllers, reorder, isDone) = element;
                      return _buildPage(
                        context,
                        todoScrollController,
                        tasks,
                        taskNotifier,
                        controllers,
                        reorder,
                        isDone: isDone,
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    ScrollController todoScrollController,
    List<Task> tasks,
    ToDoList taskNotifier,
    List<TextEditingController> controllers,
    void Function(int oldIndex, int newIndex) reorder, {
    required bool isDone,
  }) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.only(right: 12, bottom: 72 + 16),
      proxyDecorator: (child, index, animation) => child,
      scrollController: todoScrollController,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return Card(
          key: Key('${task.id}'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ListTile(
                leading: Checkbox(
                  value: isDone,
                  onChanged: (done) => taskNotifier.toggle(task.id),
                ),
                trailing: IconButton(
                  onPressed: () => taskNotifier.remove(task.id),
                  icon: const Icon(Icons.delete),
                ),
                title: TextFormField(
                  controller: controllers[index],
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Input your task here',
                  ),
                  style: isDone
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                  onTapOutside: (_) => taskNotifier.edit(
                    task.id,
                    controllers[index].text,
                  ),
                  onEditingComplete: () => taskNotifier.edit(
                    task.id,
                    controllers[index].text,
                  ),
                  onSaved: (_) => taskNotifier.edit(
                    task.id,
                    controllers[index].text,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: tasks.length,
      onReorderStart: (_) => FocusScope.of(context).unfocus(),
      onReorder: reorder,
    );
  }
}
