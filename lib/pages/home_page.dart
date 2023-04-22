import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/full_screen_page.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/to_do_list_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/widgets/state_text.dart';
import 'package:gameodoro/widgets/timer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
        return null;
      },
      [],
    );
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final isRunning =
        ref.watch(sessionProvider.select((value) => value.stopwatchState)) ==
            StopwatchState.started;
    final radius = min(
      min(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      360,
    );
    final duration = ref.watch(
      sessionProvider.select(
        (value) => value.duration.inMilliseconds,
      ),
    );
    final elapsed = ref.watch(
      sessionProvider.select(
        (value) => value.elapsed > 0 ? value.elapsed + 100 : 0,
      ),
    );
    final percent = min(1, elapsed / duration);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: CircularPercentIndicator(
                radius: radius.toDouble() / 2,
                animation: true,
                animationDuration: 100,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                percent: percent.toDouble(),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const StateText(),
                    // SizedBox(
                    //   height: Theme.of(context)
                    //           .textTheme
                    //           .titleLarge
                    //           ?.fontSize ??
                    //       32,
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      child: Timer(),
                    ),
                    buildButtons(sessionNotifier, isRunning),
                  ],
                ),
              ),
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
                    buildVerticalDivider(),
                    Tooltip(
                      message: 'Notification Sound',
                      child: IconButton(
                        onPressed: () => handleTuneButton(context),
                        icon: const Icon(Icons.music_note),
                      ),
                    ),
                    buildVerticalDivider(),
                    Tooltip(
                      message: 'To Do List',
                      child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute<Widget>(
                            builder: (context) => const ToDoListPage(),
                          ),
                        ),
                        icon: const Icon(Icons.edit_note),
                      ),
                    ),
                    buildVerticalDivider(),
                    Tooltip(
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
                    )
                  ],
                ),
              ),
            )
          ],
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

  Padding buildVerticalDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ColoredBox(
        color: Colors.grey,
        child: SizedBox(height: 24, width: 1),
      ),
    );
  }

  Row buildButtons(Session sessionNotifier, bool isRunning) {
    return Row(
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
        Tooltip(
          message: 'Previous Session',
          child: Hero(
            tag: 'button-previous',
            child: IconButton(
              onPressed: sessionNotifier.previous,
              icon: const Icon(Icons.skip_previous),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilledButton(
              onPressed: () {
                if (isRunning) {
                  sessionNotifier.pause();
                } else {
                  sessionNotifier.start();
                }
              },
              child: Text(isRunning ? 'Pause' : 'Start'),
            ),
          ),
        ),
        Tooltip(
          message: 'Next Session',
          child: Hero(
            tag: 'button-next',
            child: IconButton(
              onPressed: sessionNotifier.next,
              icon: const Icon(Icons.skip_next),
            ),
          ),
        ),
      ],
    );
  }

  void handleTuneButton(BuildContext context) {
    showDialog<Widget>(
      context: context,
      builder: (context) => const _TuneWidget(),
    );
  }
}

class _TuneWidget extends StatelessWidget {
  const _TuneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Tune',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onTap: () {},
                            leading: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow),
                            ),
                            trailing: Radio(
                              value: false,
                              groupValue: true,
                              onChanged: (value) {},
                            ),
                            title: const Text('Select custom sound...'),
                          );
                        }
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onTap: () {},
                          leading: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                          ),
                          trailing: Radio(
                            value: true,
                            groupValue: true,
                            onChanged: (value) {},
                          ),
                          title: const Text('Tune title'),
                        );
                      },
                      itemCount: 1 + 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
