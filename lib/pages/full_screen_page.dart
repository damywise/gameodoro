import 'package:flutter/material.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/widgets/timer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FullScreenPage extends ConsumerWidget {
  const FullScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(sessionProvider.select((value) => value.data));
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final studyState =
        ref.watch(sessionProvider.select((value) => value.studyState));
    final isRunning =
        ref.watch(sessionProvider.select((value) => value.stopwatchState)) ==
            StopwatchState.started;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(selected.name),
                  Text(studyState.toString()),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Timer(),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  IconButton(
                    onPressed: () {
                      if (isRunning) {
                        sessionNotifier.pause();
                      } else {
                        sessionNotifier.start();
                      }
                    },
                    icon: Icon(
                      size: 32,
                      isRunning ? Icons.pause : Icons.play_arrow,
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_fullscreen),
            ),
          ],
        ),
      ),
    );
  }
}
