import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/full_screen_page.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/settings_page.dart';
import 'package:gameodoro/pages/to_do_list_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/providers/tune.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/state_text.dart';
import 'package:gameodoro/widgets/timer.dart';
import 'package:gameodoro/widgets/timer_picker.dart';
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

    final divider = SizedBox(
      height: context.textTheme.titleLarge?.fontSize ?? 32,
    );

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Stack(
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
                    progressColor: context.colorScheme.primary,
                    backgroundColor: context.colorScheme.onPrimary,
                    percent: percent.toDouble(),
                    center: Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 24,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => showDialog<Widget>(
                          context: context,
                          builder: (context) {
                            return const Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: CloseButton(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 32.0),
                                      child: TimerPicker(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            divider,
                            divider,
                            const StateText(),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                              ),
                              child: Timer(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: buildButtons(
                                context,
                                sessionNotifier,
                                isRunning: isRunning,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            onPressed: () => Navigator.of(context).pushNamed(
                              FullScreenPage.route,
                            ),
                            icon: const Icon(Icons.fullscreen),
                          ),
                        ),
                        buildVerticalDivider(),
                        Tooltip(
                          message: 'To Do List',
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                              ToDoListPage.route,
                            ),
                            icon: const Icon(Icons.edit_note),
                          ),
                        ),
                        buildVerticalDivider(),
                        Tooltip(
                          message: 'Games',
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                GamesPage.route,
                              );
                            },
                            icon: const Icon(Icons.videogame_asset),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Tooltip(
                  message: 'Settings',
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        SettingsPage.route,
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVerticalDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ColoredBox(
        color: Colors.grey,
        child: SizedBox(height: 24, width: 1),
      ),
    );
  }

  Widget buildButtons(
    BuildContext context,
    Session sessionNotifier, {
    required bool isRunning,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'Previous Session',
              child: Hero(
                tag: 'button-previous',
                child: IconButton(
                  onPressed: sessionNotifier.previous,
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 32,
                  ),
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                if (isRunning) {
                  sessionNotifier.pause();
                } else {
                  sessionNotifier.start();
                }
              },
              child: AnimatedSize(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: Text(isRunning ? 'Pause' : 'Start'),
              ),
            ),
            Tooltip(
              message: 'Next Session',
              child: Hero(
                tag: 'button-next',
                child: IconButton(
                  onPressed: sessionNotifier.next,
                  icon: const Icon(
                    Icons.skip_next,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'Reset Timer',
              child: IconButton(
                onPressed: () {
                  sessionNotifier.reset();
                },
                icon: const Icon(Icons.replay),
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
          ],
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

/// This is a separate class for easier debugging (hot reload)
class _TuneWidget extends HookConsumerWidget {
  const _TuneWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tunes = ref.watch(tuneProvider);
    final tunesNotifier = ref.watch(tuneProvider.notifier);
    final player = useMemoized(AudioPlayer.new);
    final playingIndex = useState(-1);
    useEffect(
      () {
        player.onPlayerComplete.listen((_) {
          playingIndex.value = -1;
        });
        return null;
      },
      [],
    );

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: CloseButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Tune',
                  style: context.textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onTap: () => tunesNotifier.select(index),
                          leading: tunes[index].path.isEmpty
                              ? null
                              : playingIndex.value == index
                                  ? IconButton(
                                      onPressed: () {
                                        playingIndex.value = -1;
                                        player.stop();
                                      },
                                      icon: const Icon(Icons.stop),
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        playingIndex.value = index;
                                        await player.play(
                                          AssetSource(tunes[index].path),
                                        );
                                      },
                                      icon: const Icon(Icons.play_arrow),
                                    ),
                          trailing: Radio(
                            value: tunes[index].selected,
                            groupValue: true,
                            onChanged: (value) => tunesNotifier.select(index),
                          ),
                          title: Text(tunes[index].title),
                        );
                      },
                      itemCount: tunes.length,
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
