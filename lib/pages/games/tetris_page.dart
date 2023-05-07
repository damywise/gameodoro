import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/providers/tetris.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TetrisPage extends HookConsumerWidget {
  const TetrisPage({super.key});

  static const route = '${GamesPage.route}/tetris';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colors = getColors();
    final sessionState =
        ref.watch(sessionProvider.select((value) => value.sessionState));
    final isFocusing = sessionState == SessionState.focus;
    final isPlaying =
        ref.watch(tetrisProvider.select((value) => value.isPlaying));
    final isPaused =
        ref.watch(tetrisProvider.select((value) => value.isPaused));
    final isGameover =
        ref.watch(tetrisProvider.select((value) => value.isGameover));
    final level = ref.watch(tetrisProvider.select((value) => value.level));

    final isDialogShowing = useState(false);

    ref.listen(sessionProvider.select((value) => value.sessionState), (
      previous,
      next,
    ) {
      if (next == SessionState.focus) {
        if (!isDialogShowing.value) {
          isDialogShowing.value = true;
          showDialog<Widget>(
            context: context,
            builder: (context) =>
                AlertDialogWidget(isDialogShowing: isDialogShowing),
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
                  AlertDialogWidget(isDialogShowing: isDialogShowing),
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
        backgroundColor: context.colorScheme.surfaceVariant,
        body: SafeArea(
          minimum: safeAreaMinimumEdgeInsets,
          child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent),
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
                                                  style: context
                                                      .textTheme.headlineLarge,
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
                                    child: _buildControls(ref),
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
    final game = ref.watch(tetrisProvider.notifier);
    if (isPaused) {
      game.play();
    } else if (isPlaying) {
      game.pause();
    } else {
      game.start();
    }
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    required this.isDialogShowing,
    super.key,
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
          FloatingActionButton.large(
            heroTag: '1',
            onPressed: ref.watch(tetrisProvider.notifier).rotate,
            child: const Icon(Icons.rotate_right),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton.large(
            heroTag: '2',
            onPressed: () =>
                ref.watch(tetrisProvider.notifier).move(AxisDirection.left),
            child: const Icon(Icons.arrow_left),
          ),
          FloatingActionButton.large(
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
          FloatingActionButton.large(
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
