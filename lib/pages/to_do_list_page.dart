import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/to_do_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToDoListPage extends HookConsumerWidget {
  const ToDoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(toDoListProvider.select((value) => value.tasks));
    final controllers = useMemoized(
      () => tasks
          .map(
            (e) => TextEditingController(text: e.content),
          )
          .toList(),
      [tasks],
    );
    final taskNotifier = ref.watch(toDoListProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: taskNotifier.add,
        child: const Tooltip(message: 'Add task', child: Icon(Icons.add)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ReorderableListView.builder(
          proxyDecorator: (child, index, animation) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(child: child),
          ),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Padding(
              key: Key('${task.id}'),
              padding: const EdgeInsets.only(right: 16),
              child: ListTile(
                leading: Checkbox(
                  value: task.done,
                  onChanged: (done) => taskNotifier.edit(task.id, done: done),
                ),
                trailing: IconButton(
                  onPressed: () => taskNotifier.remove(task.id),
                  icon: const Icon(Icons.delete),
                ),
                title: TextFormField(
                  controller: controllers[index],
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: task.done
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                  decoration: const InputDecoration(
                    hintText: 'Input your task here',
                  ),
                  onTapOutside: (_) => taskNotifier.edit(
                    task.id,
                    content: controllers[index].text,
                  ),
                  onEditingComplete: () => taskNotifier.edit(
                    task.id,
                    content: controllers[index].text,
                  ),
                  onSaved: (_) => taskNotifier.edit(
                    task.id,
                    content: controllers[index].text,
                  ),
                ),
              ),
            );
          },
          itemCount: tasks.length,
          onReorderStart: (_) => FocusScope.of(context).unfocus(),
          onReorder: taskNotifier.reorder,
        ),
      ),
    );
  }
}
