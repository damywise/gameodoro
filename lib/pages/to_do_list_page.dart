import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/to_do_list.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToDoListPage extends HookConsumerWidget {
  const ToDoListPage({super.key});

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

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoScrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
          taskNotifier.add();
        },
        child: const Tooltip(message: 'Add task', child: Icon(Icons.add)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
              child: Text(
                'Ongoing',
                style: context.textTheme.titleLarge,
              ),
            ),
            Flexible(
              child: ReorderableListView.builder(
                padding: const EdgeInsets.only(right: 12),
                proxyDecorator: (child, index, animation) => child,
                scrollController: todoScrollController,
                itemBuilder: (context, index) {
                  final task = tasksTodo[index];

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
                            value: false,
                            onChanged: (done) => taskNotifier.toggle(task.id),
                          ),
                          trailing: IconButton(
                            onPressed: () => taskNotifier.remove(task.id),
                            icon: const Icon(Icons.delete),
                          ),
                          title: TextFormField(
                            controller: controllersTodo[index],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Input your task here',
                            ),
                            onTapOutside: (_) => taskNotifier.edit(
                              task.id,
                              controllersTodo[index].text,
                            ),
                            onEditingComplete: () => taskNotifier.edit(
                              task.id,
                              controllersTodo[index].text,
                            ),
                            onSaved: (_) => taskNotifier.edit(
                              task.id,
                              controllersTodo[index].text,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: tasksTodo.length,
                onReorderStart: (_) => FocusScope.of(context).unfocus(),
                onReorder: taskNotifier.reorderTodo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
              child: Text(
                'Finished',
                style: context.textTheme.titleLarge,
              ),
            ),
            Flexible(
              child: ReorderableListView.builder(
                padding: const EdgeInsets.only(right: 12),
                proxyDecorator: (child, index, animation) => child,
                itemBuilder: (context, index) {
                  final task = tasksDone[index];

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
                            value: true,
                            onChanged: (done) => taskNotifier.toggle(task.id),
                          ),
                          trailing: IconButton(
                            onPressed: () => taskNotifier.remove(task.id),
                            icon: const Icon(Icons.delete),
                          ),
                          title: TextFormField(
                            controller: controllersDone[index],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Input your task here',
                            ),
                            onTapOutside: (_) => taskNotifier.edit(
                              task.id,
                              controllersDone[index].text,
                            ),
                            onEditingComplete: () => taskNotifier.edit(
                              task.id,
                              controllersDone[index].text,
                            ),
                            onSaved: (_) => taskNotifier.edit(
                              task.id,
                              controllersDone[index].text,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: tasksDone.length,
                onReorderStart: (_) => FocusScope.of(context).unfocus(),
                onReorder: taskNotifier.reorderDone,
              ),
            ),
            const SizedBox(
              height: 72,
            ),
          ],
        ),
      ),
    );
  }
}
