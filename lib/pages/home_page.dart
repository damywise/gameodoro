import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/full_screen_page.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/timer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final studyState =
        ref.watch(sessionProvider.select((value) => value.studyState));
    final isRunning =
        ref.watch(sessionProvider.select((value) => value.stopwatchState)) ==
            StopwatchState.started;
    final stateText = useState('');
    useEffect(
      () {
        getStudyStateName(studyState, stateText);
        return null;
      },
      [studyState],
    );
    final maxHeight = Theme.of(context).textTheme.displayLarge?.fontSize ?? 57;
    final radius = min(MediaQuery.of(context).size.width, 240.0);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: radius,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              Center(
                                child: CircularPercentIndicator(
                                  radius: radius / 2,
                                  animation: true,
                                  animationDuration: 100,
                                  animateFromLastPercent: true,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  percent: min(
                                    1,
                                    ref.watch(
                                          sessionProvider.select(
                                              (value) => value.elapsed + 100),
                                        ) /
                                        sessionNotifier.duration().inMilliseconds,
                                  ),
                                  center: const Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: Timer(),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: maxHeight * 2),
                                  child: Text(
                                    stateText.value,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tooltip(
                //   message: 'Reset Timer',
                //   child: IconButton(
                //     onPressed: () {
                //       session.streamController().add(0);
                //       session.stopwatch().reset();
                //     },
                //     icon: const Icon(Icons.replay),
                //   ),
                // ),
                FilledButton(
                  onPressed: () {
                    if (isRunning) {
                      sessionNotifier.pause();
                    } else {
                      sessionNotifier.start();
                    }
                  },
                  child: Text(isRunning ? 'Pause' : 'Start'),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Fullscreen',
                      child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute<Widget>(
                            builder: (context) => const FullScreenPage(),
                          ),
                        ),
                        icon: const Icon(Icons.fullscreen),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ColoredBox(
                        color: Colors.grey,
                        child: SizedBox(height: 24, width: 1),
                      ),
                    ),
                    Tooltip(
                      message: 'Notification Sound',
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.music_note),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Tooltip(
              message: 'Games',
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<Widget>(
                      builder: (context) => const GamesPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.videogame_asset),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Tooltip(
              message: 'Setting',
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<Widget>(
                      builder: (context) => const GamesPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
