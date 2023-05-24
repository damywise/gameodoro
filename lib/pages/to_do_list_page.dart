import 'package:flutter/material.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/gameodoro_logo.dart';
import 'package:gameodoro/widgets/to_do_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToDoListPage extends ConsumerWidget {
  const ToDoListPage({super.key});

  static const route = '/todolist';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('To Do List'),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Logo(
                  showText: false,
                ),
              )
            ],
          ),
          body: const ToDoList(),
        ),
      ),
    );
  }
}
