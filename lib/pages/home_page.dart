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
import 'package:gameodoro/widgets/gameodoro_logo.dart';
import 'package:gameodoro/widgets/notification_widget.dart';
import 'package:gameodoro/widgets/state_text.dart';
import 'package:gameodoro/widgets/timer.dart';
import 'package:gameodoro/widgets/timer_picker.dart';
import 'package:gameodoro/widgets/to_do_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// notif
    ref.listen(sessionProvider, (previous, next) {
      // Notification is only triggered when changing session with timer, not
      // manually.
      // Also, notification can be disabled
      if (next.sessionState != previous?.sessionState &&
          next.elapsed + 200 >= (previous?.duration.inMilliseconds ?? 0) &&
          (ref.read(sharedPreferences).getBool('enablenotification') ?? true)) {
        showTopSnackBar(
          Overlay.of(context),
          SafeArea(
            minimum: safeAreaMinimumEdgeInsets,
            child: NotificationWidget(
              key: Key(Random.secure().nextInt(100000).toString()),
              ref: ref,
              state: next.sessionState,
            ),
          ),
          dismissDirection: const [
            DismissDirection.up,
            DismissDirection.horizontal
          ],
          dismissType: DismissType.onSwipe,
        );
      }
    });

    final prefs = ref.read(sharedPreferences);

    final keys = [
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
      useMemoized(GlobalKey.new),
    ];

    final [
      timerCardKey,
      sessionStateTextKey,
      startButtonKey,
      previousButtonKey,
      nextButtonKey,
      resetButtonKey,
      notificationButtonKey,
      todolistKey,
      todolistButtonKey,
      fullscreenButtonKey,
      gamesButtonKey,
      settingButtonKey,
      tutorialButtonKey,
    ] = keys;

    useEffect(
      () {
        if (ref.read(sharedPreferences).getBool('firstopen') ?? true) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Future<void>.delayed(
              const Duration(seconds: 1),
              () => startShowcase(context, keys, ref),
            ),
          );
        }
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
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Logo(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  height: 48,
                ),
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
                    center: Showcase(
                      key: timerCardKey,
                      description: 'This is the pomodoro timer.\n'
                          'You can tap on the timer to modify focus, short break, and long break session durations\n'
                          '\nTap anywhere to continue',
                      targetShapeBorder: const CircleBorder(),
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        elevation: 24,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            showDialog<Widget>(
                              context: context,
                              builder: (context) => const _TimerPickerDialog(),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              divider,
                              divider,
                              Showcase(
                                key: sessionStateTextKey,
                                targetPadding: const EdgeInsets.all(12),
                                description:
                                    'This text shows the current session mode.\n'
                                    'There 3 modes: "Focus", "Short Break, and "Long Break".',
                                child: const StateText(),
                              ),
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
                                  (
                                    startButtonKey,
                                    previousButtonKey,
                                    nextButtonKey,
                                    resetButtonKey,
                                    notificationButtonKey,
                                  ),
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
                ),
                Expanded(
                  child: Showcase(
                    key: todolistKey,
                    description: 'This is a todo list preview.\n'
                        'You can use the "Todo List" button below '
                        'to further manage your tasks.',
                    child: const Padding(
                      padding: EdgeInsets.all(32),
                      child: ToDoList(
                        page: false,
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
                        Showcase(
                          key: fullscreenButtonKey,
                          description: 'Fullscreen focus mode',
                          child: TextButton.icon(
                            onPressed: () => Navigator.of(context).pushNamed(
                              FullScreenPage.route,
                            ),
                            icon: const Icon(Icons.fullscreen),
                            label: const Text('Fullscreen'),
                          ),
                        ),
                        buildVerticalDivider(),
                        Showcase(
                          key: todolistButtonKey,
                          description: 'Todo List, manage your tasks here',
                          child: TextButton.icon(
                            onPressed: () => Navigator.of(context).pushNamed(
                              ToDoListPage.route,
                            ),
                            icon: const Icon(Icons.edit_note),
                            label: const Text('Todo List'),
                          ),
                        ),
                        buildVerticalDivider(),
                        Showcase(
                          key: gamesButtonKey,
                          description:
                              'You can play games during break session.\nGames will be locked when focus session starts.',
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                GamesPage.route,
                              );
                            },
                            icon: const Icon(Icons.videogame_asset),
                            label: const Text('Games'),
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
                child: Row(
                  children: [
                    Showcase(
                      key: settingButtonKey,
                      description: 'All settings are over here',
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
                    Showcase(
                      key: tutorialButtonKey,
                      description:
                          'You can repeat this tutorial anytime you want',
                      onBarrierClick: () {
                        prefs.setBool('firstopen', false);
                        ref.read(tutorialRunning.notifier).state = false;
                      },
                      child: Tooltip(
                        message: 'Tutorial',
                        child: IconButton(
                          onPressed: () => startShowcase(context, keys, ref),
                          icon: const Icon(Icons.info),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startShowcase(
    BuildContext context,
    List<GlobalKey<State<StatefulWidget>>> keys,
    WidgetRef ref,
  ) {
    ref.read(tutorialRunning.notifier).state = true;
    ShowCaseWidget.of(context).startShowCase(keys);
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
    (
      GlobalKey startButtonKey,
      GlobalKey previousButtonKey,
      GlobalKey nextButtonKey,
      GlobalKey resetButtonKey,
      GlobalKey notificationButtonKey,
    ) keys,
    Session sessionNotifier, {
    required bool isRunning,
  }) {
    final (
      startButtonKey,
      previousButtonKey,
      nextButtonKey,
      resetButtonKey,
      notificationButtonKey,
    ) = keys;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Showcase(
              key: previousButtonKey,
              description: 'Go back to previous session',
              targetPadding: const EdgeInsets.all(-4),
              child: Tooltip(
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
            ),
            Showcase(
              key: startButtonKey,
              description: 'Tap this button to start the pomodoro session',
              targetShapeBorder: const CircleBorder(),
              child: FilledButton(
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
            ),
            Showcase(
              key: nextButtonKey,
              description: 'Skip to the next session',
              targetPadding: const EdgeInsets.all(-4),
              child: Tooltip(
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
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Showcase(
              key: resetButtonKey,
              description: 'Reset the timer for current session',
              child: Tooltip(
                message: 'Reset Timer',
                child: IconButton(
                  onPressed: () {
                    sessionNotifier.reset();
                  },
                  icon: const Icon(Icons.replay),
                ),
              ),
            ),
            buildVerticalDivider(),
            Showcase(
              key: notificationButtonKey,
              description:
                  "Change the notification sound.\nIt's silent by default",
              child: Tooltip(
                message: 'Notification Sound',
                child: IconButton(
                  onPressed: () => handleTuneButton(context),
                  icon: const Icon(Icons.music_note),
                ),
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

/// This is a separate widget because showDialog doesn't work correctly
/// otherwise
class _TimerPickerDialog extends HookWidget {
  const _TimerPickerDialog();

  @override
  Widget build(BuildContext context) {
    final showFirst = useState(true);
    // This is a workaround because for some reason when the mouse is at the
    // position of CupertinoTimerPicker when first painted, it throws exception
    // `child paint transform happened to be null.`
    // and
    // `_debugDuringDeviceUpdate`
    useEffect(() {
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          showFirst.value = false;
        }
      });
      return null;
    });
    return Align(
      child: SizedBox(
        width: 320,
        height: 380,
        child: Material(
          color: Colors.transparent,
          child: Card(
            elevation: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CloseButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: const TimerPicker(),
                      crossFadeState: showFirst.value
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 200),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// This is a separate widget because showDialog doesn't work correctly
/// otherwise
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
          if (context.mounted) {
            playingIndex.value = -1;
          }
        });

        return null;
      },
      [],
    );

    return Align(
      child: SizedBox(
        width: 320,
        height: 400,
        child: Material(
          color: Colors.transparent,
          child: Card(
            elevation: double.infinity,
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
                                  onChanged: (value) =>
                                      tunesNotifier.select(index),
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
          ),
        ),
      ),
    );
  }
}
