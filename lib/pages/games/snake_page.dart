import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/providers/snake.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/alert_dialog_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnakePage extends HookConsumerWidget {
  const SnakePage({super.key});

  static const route = '${GamesPage.route}/snake';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState =
        ref.watch(sessionProvider.select((value) => value.sessionState));
    final isFocusing = sessionState == SessionState.focus;
    final isPlaying =
        ref.watch(snakeProvider.select((value) => value.isPlaying));
    final isPaused = ref.watch(snakeProvider.select((value) => value.isPaused));
    final isGameover =
        ref.watch(snakeProvider.select((value) => value.isGameover));
    final level = ref.watch(snakeProvider.select((value) => value.level));

    final isDialogShowing = useState(false);

    final direction =
        ref.watch(snakeProvider.select((value) => value.direction));

    ref.listen(sessionProvider.select((value) => value.sessionState), (
      previous,
      next,
    ) {
      if (next == SessionState.focus) {
        ref.read(snakeProvider.notifier).pause();
        if (!isDialogShowing.value) {
          isDialogShowing.value = true;
          showDialog<Widget>(
            context: context,
            builder: (context) => AlertDialogWidget(
              isDialogShowing: isDialogShowing,
              dispose: ref.read(snakeProvider.notifier).dispose,
            ),
            barrierDismissible: false,
          );
        }
      } else if (isDialogShowing.value) {
        isDialogShowing.value = false;
        Navigator.of(context).pop();
      }
    });

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!isDialogShowing.value && isFocusing) {
            isDialogShowing.value = true;
            showDialog<Widget>(
              context: context,
              builder: (context) => AlertDialogWidget(
                isDialogShowing: isDialogShowing,
                dispose: ref.read(snakeProvider.notifier).dispose,
              ),
              barrierDismissible: false,
            );
          }
        });

        return null;
      },
      [],
    );

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (value) {
        final game = ref.watch(snakeProvider.notifier);
        if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          game.move(AxisDirection.right);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          game.move(AxisDirection.left);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          game.move(AxisDirection.up);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          game.move(AxisDirection.down);
        }
      },
      child: WillPopScope(
        onWillPop: ref.read(snakeProvider.notifier).dispose,
        child: Scaffold(
          backgroundColor: context.colorScheme.surfaceVariant,
          body: SafeArea(
            minimum: safeAreaMinimumEdgeInsets,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 10 / 18,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Card(
                                    color: Theme.of(context).cardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  return buildTiles(level);
                                                },
                                              ),
                                              if (isGameover && !isPlaying) ...[
                                                Center(
                                                  child: Text(
                                                    'Game Over',
                                                    style: context
                                                        .textTheme.headlineLarge
                                                        ?.copyWith(
                                                      foreground: Paint()
                                                        ..color = Theme.of(
                                                                  context,
                                                                ).brightness ==
                                                                Brightness.dark
                                                            ? Colors.black
                                                            : Colors.white
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 2.0,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    'Game Over',
                                                    style: context.textTheme
                                                        .headlineLarge,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FilledButton(
                                onPressed: () => handleStartButton(
                                  ref,
                                  isPaused: isPaused,
                                  isPlaying: isPlaying,
                                ),
                                child: Text(
                                  getStartButtonText(
                                    isGameover: isGameover,
                                    isPaused: isPaused,
                                    isPlaying: isPlaying,
                                  ),
                                ),
                              ),
                              FilledButton(
                                onPressed: ref.read(snakeProvider.notifier).end,
                                child: const Text(
                                  'End Game',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: 240 + 48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: (Theme.of(context)
                                                .floatingActionButtonTheme
                                                .largeSizeConstraints
                                                ?.maxWidth ??
                                            96) *
                                        3,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: _buildControls(
                                        ref,
                                        context,
                                        direction,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getStartButtonText({
    required bool isGameover,
    required bool isPaused,
    required bool isPlaying,
  }) {
    if (isGameover) return 'Restart';
    if (isPaused) return 'Play';
    if (isPlaying) return 'Pause';

    return 'Start';
  }

  void handleStartButton(
    WidgetRef ref, {
    required bool isPaused,
    required bool isPlaying,
  }) {
    final game = ref.watch(snakeProvider.notifier);
    if (isPaused) {
      game.play();
    } else if (isPlaying) {
      game.pause();
    } else {
      game.start();
    }
  }

  Widget _buildControls(
    WidgetRef ref,
    BuildContext context,
    AxisDirection direction,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.large(
              backgroundColor: direction == AxisDirection.up
                  ? Theme.of(context).buttonTheme.colorScheme?.primaryContainer
                  : Theme.of(context).buttonTheme.colorScheme?.primary,
              heroTag: '1',
              onPressed: () =>
                  ref.watch(snakeProvider.notifier).move(AxisDirection.up),
              child: Icon(
                Icons.arrow_drop_up,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.large(
              backgroundColor: direction == AxisDirection.left
                  ? Theme.of(context).buttonTheme.colorScheme?.primaryContainer
                  : Theme.of(context).buttonTheme.colorScheme?.primary,
              heroTag: '2',
              onPressed: () =>
                  ref.watch(snakeProvider.notifier).move(AxisDirection.left),
              child: Icon(
                Icons.arrow_left,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            FloatingActionButton.large(
              backgroundColor: direction == AxisDirection.right
                  ? Theme.of(context).buttonTheme.colorScheme?.primaryContainer
                  : Theme.of(context).buttonTheme.colorScheme?.primary,
              heroTag: '3',
              onPressed: () =>
                  ref.watch(snakeProvider.notifier).move(AxisDirection.right),
              child: Icon(
                Icons.arrow_right,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.large(
              backgroundColor: direction == AxisDirection.down
                  ? Theme.of(context).buttonTheme.colorScheme?.primaryContainer
                  : Theme.of(context).buttonTheme.colorScheme?.primary,
              heroTag: '4',
              onPressed: () => ref.watch(snakeProvider.notifier).move(
                    AxisDirection.down,
                  ),
              child: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTiles(List<List<int>> level) {
    return Row(
      children: level
          .map(
            (column) => Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: column
                    .map(
                      (block) => Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: switch (block) {
                                  > 2 => Colors.blue
                                      .withBlue(150 * (180 - block) ~/ 180)
                                      .withGreen(120 * (180 - block) ~/ 180),
                                  2 => Colors.lightBlueAccent,
                                  1 => Colors.orangeAccent,
                                  _ => Colors.grey.withOpacity(.2),
                                },
                                borderRadius: BorderRadius.circular(
                                  2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}
