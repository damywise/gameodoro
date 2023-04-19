import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/widgets/state_text.dart';
import 'package:gameodoro/widgets/timer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FullScreenPage extends HookConsumerWidget {
  const FullScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        return null;
      },
      [],
    );

    final selected = ref.watch(sessionProvider.select((value) => value.data));
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final isRunning =
        ref.watch(sessionProvider.select((value) => value.stopwatchState)) ==
            StopwatchState.started;
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
        return true;
      },
      child: Theme(
        data: ThemeData.dark(useMaterial3: true),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(selected.name),
                      const StateText(),
                      const Expanded(
                        child: Timer(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: IconButton(
                          onPressed: () {
                            if (isRunning) {
                              sessionNotifier.pause();
                            } else {
                              sessionNotifier.start();
                            }
                          },
                          icon: Icon(
                            size: 48,
                            isRunning ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close_fullscreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
