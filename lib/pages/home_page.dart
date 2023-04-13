import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider.notifier);
    final stream = session.stream();

    final sessionDuration = session.duration();

    final isAnimating = useState(false);
    final isCompleted = useCallback(
      () {
        return session.stopwatch().elapsed >= sessionDuration;
      },
      [stream],
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: stream,
            initialData: 0,
            builder: (context, snapshot) {
              var milliseconds = isCompleted()
                  ? 0
                  : sessionDuration.inMilliseconds - (snapshot.data ?? 0);
              var seconds = (milliseconds / 1000).truncate();
              var minutes = (seconds / 60).truncate();
              final hours = (minutes / 60).truncate();

              if (milliseconds <= 0) {
                seconds = 0;
                minutes = 0;
              } else {
                seconds %= 60;
                minutes %= 60;
                milliseconds %= 1000;
              }

              return Text(
                '${minutes < 10 ? '0' : ''}$minutes : ${'${seconds < 10 ? '0' : ''}$seconds'}',
                style: Theme.of(context)
                    .typography
                    .dense
                    .displayLarge
                    ?.copyWith(color: Colors.black),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: 'Reset Timer',
                child: IconButton(
                  onPressed: () {
                    session.streamController().add(0);
                    session.stopwatch().reset();
                  },
                  icon: const Icon(Icons.replay),
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (session.stopwatch().isRunning) {
                    isAnimating.value = false;
                    session.stopwatch().stop();
                  } else {
                    isAnimating.value = true;
                    session.stopwatch().start();
                  }
                },
                child: Text(session.stopwatch().isRunning ? 'Pause' : 'Start'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
