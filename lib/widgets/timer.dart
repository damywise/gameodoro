import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Timer extends ConsumerWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsed = ref.watch(sessionProvider.select((value) => value.elapsed));
    final duration =
        ref.watch(sessionProvider.select((value) => value.duration));

    var milliseconds =
        duration.inMilliseconds - elapsed + (elapsed > 0 ? 1000 : 0);
    var seconds = (milliseconds / 1000).truncate();
    var minutes = (seconds / 60).truncate();
    // final hours = (minutes / 60).truncate();

    if (milliseconds <= 0) {
      seconds = 0;
      minutes = 0;
    } else {
      seconds %= 60;
      minutes %= 60;
      milliseconds %= 1000;
    }

    return Hero(
      tag: 'timer',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AutoSizeText(
              '${minutes < 10 ? '0' : ''}$minutes : ${seconds < 10 ? '0' : ''}$seconds',
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 1000),
            ),
          ),
        ],
      ),
    );
  }
}
