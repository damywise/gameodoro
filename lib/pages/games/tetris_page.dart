import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/providers/tetris.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TetrisPage extends HookConsumerWidget {
  const TetrisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colors = getColors();
    final sessionState =
        ref.watch(sessionProvider.select((value) => value.sessionState));
    final isFocusing = sessionState == StudyState.focus;
    final isPlaying =
        ref.watch(tetrisProvider.select((value) => value.isPlaying));
    final isPaused =
        ref.watch(tetrisProvider.select((value) => value.isPaused));
    final isGameover =
        ref.watch(tetrisProvider.select((value) => value.isGameover));
    final level = ref.watch(tetrisProvider.select((value) => value.level));

    final isDialogShowing = useState(false);

    ref.listen(sessionProvider.select((value) => value.sessionState),
        (previous, next) {
      if (next == StudyState.focus) {
        if (!isDialogShowing.value) {
          isDialogShowing.value = true;
          showDialog<Widget>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Time's Up"),
              content: const Text("It's study time!"),
              actions: [
                FilledButton(
                  onPressed: () {
                    isDialogShowing.value = false;
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text("Let's go!"),
                ),
              ],
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
              builder: (context) =>
                  AlertDialogWIdget(isDialogShowing: isDialogShowing),
              barrierDismissible: false,
            );
          }
        });

        return ref.read(tetrisProvider.notifier).dispose;
      },
      [],
    );

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (value) {
        final game = ref.watch(tetrisProvider.notifier);
        if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          game.move(AxisDirection.right);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          game.move(AxisDirection.left);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          game.rotate();
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          game.move(AxisDirection.down, fall: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
                                          builder: (context, constraints) {
                                            return Column(
                                              children: buildTiles(level),
                                            );
                                          },
                                        ),
                                        if (isGameover && !isPlaying) ...[
                                          Center(
                                            child: Text(
                                              'Game Over',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge
                                                  ?.copyWith(
                                                    foreground: Paint()
                                                      ..color = Theme.of(
                                                                context,
                                                              ).brightness ==
                                                              Brightness.dark
                                                          ? Colors.black
                                                          : Colors.white
                                                      ..style =
                                                          PaintingStyle
                                                              .stroke
                                                      ..strokeWidth = 2.0,
                                                  ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              'Game Over',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge,
                                            ),
                                          ),
                                        ]
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
                    const SizedBox(
                      height: 32,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: 240,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              heroTag: 'start',
                              isExtended: true,
                              onPressed: () => handleStartButton(ref, isPaused, isPlaying),
                              child: Text(
                                isGameover
                                    ? 'Restart'
                                    : isPaused
                                        ? 'Play'
                                        : isPlaying
                                            ? 'Pause'
                                            : 'Start',
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: 56 * 3,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: _buildControls(ref),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleStartButton(WidgetRef ref, bool isPaused, bool isPlaying) {
    final game =
        ref.watch(tetrisProvider.notifier);
    if (isPaused) {
      game.play();
    } else if (isPlaying) {
      game.pause();
    } else {
      game.start();
    }
  }
}

class AlertDialogWIdget extends StatelessWidget {
  const AlertDialogWIdget({
    super.key,
    required this.isDialogShowing,
  });

  final ValueNotifier<bool> isDialogShowing;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Break is Over'),
      content: const Text('Time to continue your study'),
      actions: [
        TextButton(
          onPressed: () {
            isDialogShowing.value = false;
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Go back'),
        ),
        FilledButton(
          onPressed: () {
            isDialogShowing.value = false;
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text("Let's go!"),
        ),
      ],
    );
  }
}

Widget _buildControls(WidgetRef ref) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: ref.watch(tetrisProvider.notifier).rotate,
            child: const Icon(Icons.rotate_right),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: '2',
            onPressed: () =>
                ref.watch(tetrisProvider.notifier).move(AxisDirection.left),
            child: const Icon(Icons.arrow_left),
          ),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () =>
                ref.watch(tetrisProvider.notifier).move(AxisDirection.right),
            child: const Icon(Icons.arrow_right),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: '4',
            onPressed: () => ref
                .watch(tetrisProvider.notifier)
                .move(AxisDirection.down, fall: true),
            child: const Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    ],
  );
}

List<Widget> buildTiles(List<List<int>> level) {
  return level
      .map(
        (column) => Expanded(
          child: Row(
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
                            color: getColors()[block],
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
      .toList();
}
