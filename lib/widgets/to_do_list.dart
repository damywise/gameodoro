import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/models/to_do_list_data.dart';
import 'package:gameodoro/providers/to_do_list.dart' as provider;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToDoList extends HookConsumerWidget {
  const ToDoList({super.key, this.page = true});

  final bool page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksTodo =
        ref.watch(provider.toDoListProvider.select((value) => value.tasksTodo));
    final controllersTodo = useMemoized(
      () => tasksTodo
          .map(
            (e) => TextEditingController(text: e.content),
          )
          .toList(),
      [tasksTodo],
    );

    final tasksDone =
        ref.watch(provider.toDoListProvider.select((value) => value.tasksDone));
    final controllersDone = useMemoized(
      () => tasksDone
          .map(
            (e) => TextEditingController(text: e.content),
          )
          .toList(),
      [tasksDone],
    );

    final todoScrollController = useScrollController();

    final taskNotifier = ref.watch(provider.toDoListProvider.notifier);

    final tabController = useTabController(initialLength: 2);
    final isGoingToFirstTab = useState(false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: !page
          ? null
          : FloatingActionButton(
              backgroundColor:
                  Theme.of(context).buttonTheme.colorScheme?.primary,
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
                    tabController.animateTo(0);
                    await Future<void>.delayed(
                        const Duration(milliseconds: 200));
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
          if (page) ...[
            TabBar(
              tabs: const [
                Text('Ongoing'),
                Text('Finished'),
              ],
              controller: tabController,
            )
          ] else
            Text(
              'Todo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          if (!page)
            Expanded(
              child: _buildPage(
                context,
                todoScrollController,
                tasksTodo,
                taskNotifier,
                controllersTodo,
                taskNotifier.reorderTodo,
                isDone: false,
              ),
            )
          else
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  (
                    tasksTodo,
                    todoScrollController,
                    controllersTodo,
                    taskNotifier.reorderTodo,
                    false
                  ),
                  (
                    tasksDone,
                    null,
                    controllersDone,
                    taskNotifier.reorderDone,
                    true
                  ),
                ].map<Widget>(
                  (element) {
                    final (
                      tasks,
                      scrollController,
                      controllers,
                      reorder,
                      isDone
                    ) = element;
                    return _buildPage(
                      context,
                      scrollController,
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
    );
  }

  Widget _buildPage(
    BuildContext context,
    ScrollController? scrollController,
    List<Task> tasks,
    provider.ToDoList taskNotifier,
    List<TextEditingController> controllers,
    void Function(int oldIndex, int newIndex) reorder, {
    required bool isDone,
  }) =>
      Hero(
        tag: !isDone ? 'todo' : 'done',
        child: tasks.isEmpty
            ? Center(
                child: Text(
                  "You don't have any ${!isDone ? 'ongoing' : 'finished'} tasks",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : ReorderableListView.builder(
                padding: const EdgeInsets.only(right: 12, bottom: 72 + 16),
                proxyDecorator: (child, index, animation) => child,
                scrollController: scrollController,
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
                          leading: !page
                              ? null
                              : Checkbox(
                                  value: isDone,
                                  onChanged: (done) =>
                                      taskNotifier.toggle(task.id),
                                ),
                          trailing: !page
                              ? null
                              : IconButton(
                                  onPressed: () => taskNotifier.remove(task.id),
                                  icon: const Icon(Icons.delete),
                                ),
                          title: !page
                              ? Text(controllers[index].text)
                              : TextFormField(
                                  controller: controllers[index],
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Input your task here',
                                  ),
                                  style: isDone
                                      ? const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough)
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
              ),
      );
}
