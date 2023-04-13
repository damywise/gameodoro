import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Block {
  Block(this.coordinates, this.index);

  List<int> position = [0, 0];
  final List<List<List<int>>> coordinates;
  final int index;
  int rotation = 0;
}

/// Use guideline SRS https://harddrop.com/wiki/SRS#Wall_Kicks
final List<Block> blocks = [
  Block(
    [
      [
        [1, 1, 1, 1],
      ],
      [
        [1],
        [1],
        [1],
        [1],
      ],
    ],
    0,
  ),
  Block(
    [
      [
        [1, 0, 0],
        [1, 1, 1],
      ],
      [
        [1, 1],
        [1, 0],
        [1, 0]
      ],
      [
        [1, 1, 1],
        [0, 0, 1]
      ],
      [
        [0, 1],
        [0, 1],
        [1, 1]
      ],
    ],
    1,
  ),
  Block(
    [
      [
        [0, 0, 1],
        [1, 1, 1],
      ],
      [
        [1, 0],
        [1, 0],
        [1, 1]
      ],
      [
        [1, 1, 1],
        [1, 0, 0]
      ],
      [
        [1, 1],
        [0, 1],
        [0, 1]
      ],
    ],
    2,
  ),
  Block(
    [
      [
        [1, 1],
        [1, 1],
      ]
    ],
    3,
  ),
  Block(
    [
      [
        [0, 1, 1],
        [1, 1, 0],
      ],
      [
        [1, 0],
        [1, 1],
        [0, 1]
      ],
    ],
    4,
  ),
  Block(
    [
      [
        [0, 1, 0],
        [1, 1, 1],
      ],
      [
        [1, 0],
        [1, 1],
        [1, 0]
      ],
      [
        [1, 1, 1],
        [0, 1, 0]
      ],
      [
        [0, 1],
        [1, 1],
        [0, 1]
      ],
    ],
    5,
  ),
  Block(
    [
      [
        [1, 1, 0],
        [0, 1, 1],
      ],
      [
        [0, 1],
        [1, 1],
        [1, 0]
      ],
    ],
    6,
  ),
];

class TetrisGame extends StatefulHookConsumerWidget {
  const TetrisGame({super.key});

  @override
  ConsumerState<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends ConsumerState<TetrisGame> {
  bool isPlaying = false;

  bool isPaused = false;

  bool isEnded = false;

  final colors = [
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.orangeAccent,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.grey.shade900,
    Colors.white,
  ];

  void start() {
    _level.value = List.filled(18, List.filled(10, blocks.length));
    setState(() {
      isPlaying = true;
      isPaused = false;
      isEnded = false;
    });
    startGame();
  }

  void play() {
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
  }

  void pause() {
    setState(() {
      isPaused = true;
    });
  }

  void end() {
    setState(() {
      isPlaying = false;
      isEnded = true;
    });
  }

  /// check if the block with its rotation and its coordinate can be placed
  bool canPlace(Block block) {
    // print('test');
    final level = _level.value;
    final blockCoordinate = block.coordinates[block.rotation];
    // print([blockCoordinate.first.length + block.position[1], level.length]);
    if (blockCoordinate.length + block.position[1] > level.length ||
        blockCoordinate.first.length + block.position[0] > level.first.length ||
        block.position[0] < 0) {
      return false;
    }
    // return true;
    final allTrues = <bool>[];
    for (var i = 0; i < blockCoordinate.length; i++) {
      for (var j = 0; j < blockCoordinate[i].length; j++) {
        final cell = blockCoordinate[i][j] == 1;
        if (!cell) continue;

        final posX = block.position[1] + i;
        final posY = block.position[0] + j;

        // print([posY, posX, level[posX][posY], cell, blocks.length]);
        allTrues.add(level[posX][posY] == blocks.length && cell);
      }
    }
    // print(allTrues);
    if (!allTrues.contains(false)) {
      return true;
    }
    return false;
  }

  void place(Block block, {bool bottom = false, bool remove = false}) {
    final newLevel = [..._level.value];

    final blockCoordinate = block.coordinates[block.rotation];
    for (var i = 0; i < blockCoordinate.length; i++) {
      for (var j = 0; j < blockCoordinate[i].length; j++) {
        final cell = blockCoordinate[i][j] == 1;
        if (!cell) continue;

        final posX = block.position[1] + i;
        final posY = block.position[0] + j;

        // print([posX, posY, level[posY][posX], cell, blocks.length]);

        final levelY = [...newLevel[posX]];
        levelY[posY] = remove
            ? 7
            : bottom
                ? 8
                : block.index;
        newLevel[posX] = levelY;
      }
    }
    _level.value = newLevel;
  }

  Block copyBlock(Block block) {
    final newBlock = Block(block.coordinates, block.index)
      ..rotation = block.rotation
      ..position = [...block.position];
    return newBlock;
  }

  bool choosePiece() {
    final level = _level.value;
    if (level.first.contains(8)) {
      return false;
    }
    final index = Random().nextInt(blocks.length);
    // const index = 0;
    final block = blocks[index];
    final newBlock = copyBlock(block);
    // print(block.coordinates[block.rotation]);
    var i = 0;
    do {
      i++;
      if (index > 0) {
        newBlock.position = [Random().nextInt(level.first.length - 1), 0];
      }
    } while (!canPlace(newBlock) && i < level.first.length);
    // print([index, block.position, canPlace(block)]);
    if (canPlace(newBlock)) {
      place(newBlock);
    }
    _currentBlock = newBlock;
    return true;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startGame() {
    const duration = Duration(milliseconds: 500);
    var isNotStuck = choosePiece();
    _timer.cancel();
    _timer = Timer.periodic(duration, (timer) {
      final session = ref.read(sessionProvider.notifier);
      final sessionDuration = session.duration();
      final isCompleted = session.stopwatch().elapsed >= sessionDuration;
      if (isCompleted) {
        setState(() {});
      }
      // print('test1');
      if ((!isPaused || isEnded || !isPlaying) && !isCompleted) {
        // print('test2');
        if (!move(AxisDirection.down)) {
          // print('test3');

          /// clear row and fall
          var i = -1;
          final cleared = <int>[];
          for (final row in _level.value) {
            i++;
            if (row.every((element) => element == 8)) {
              cleared.add(i);
            }
          }
          for (final j in cleared) {
            _level.value.removeAt(j);
            _level.value = [
              List.filled(_level.value.first.length, 7),
              ..._level.value,
            ];
          }
          isNotStuck = choosePiece();
          if (!isNotStuck) {
            // print(isNotStuck);
            setState(() {
              isEnded = true;
              isPlaying = false;
            });
            timer.cancel();
          }
        }
      }
    });
  }

  bool move(AxisDirection direction, {bool fall = false}) {
    // print('testmove');
    if (!isPlaying && isEnded) {
      return false;
    }
    if (isPaused) {
      return true;
    }
    if (_currentBlock == null) return false;
    final block = _currentBlock!;
    if (fall) {
      while (move(AxisDirection.down)) {}
      return false;
    }
    final newBlock = copyBlock(block);

    if (direction == AxisDirection.down) newBlock.position[1]++;
    if (direction == AxisDirection.left) newBlock.position[0]--;
    if (direction == AxisDirection.right) newBlock.position[0]++;

    place(block, remove: true);
    if (canPlace(newBlock)) {
      place(newBlock);
      _currentBlock = newBlock;
      return true;
    } else if (direction == AxisDirection.down) {
      place(block, bottom: true);
    } else {
      place(block);
    }
    return false;
  }

  final _level = ValueNotifier(List.filled(18, List.filled(10, blocks.length)));
  Block? _currentBlock;
  Timer _timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider.notifier);
    final sessionDuration = session.duration();
    final isCompleted = session.stopwatch().elapsed >= sessionDuration;
    // print(_level);
    // print(_level.value.length);

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          move(AxisDirection.right);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          move(AxisDirection.left);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          rotate();
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          move(AxisDirection.down, fall: true);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        body: WillPopScope(
          onWillPop: () async {
            // if (Platform.isAndroid) {
            //   await SystemChrome.setEnabledSystemUIMode(
            //     SystemUiMode.edgeToEdge,
            //     overlays: SystemUiOverlay.values,
            //   );
            // }
            return Navigator.of(context).maybePop();
          },
          child: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ValueListenableBuilder(
                    valueListenable: _level,
                    builder: (context, level, child) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 32),
                                  // padding: EdgeInsets.symmetric(
                                  //   horizontal: max(
                                  //       0,
                                  //       constraints.maxWidth / 2 -
                                  //           5 *
                                  //               (constraints.maxHeight /
                                  //                   level.length) +
                                  //           15),
                                  // ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 32),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Stack(
                                          children: [
                                            LayoutBuilder(
                                              builder: (context, constraints) {
                                                return Column(
                                                  children: level
                                                      .map(
                                                        (column) => Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: column
                                                                .map(
                                                                  (block) =>
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                    child:
                                                                        Container(
                                                                      width: constraints.maxWidth /
                                                                              level
                                                                                  .length +
                                                                          constraints.maxWidth /
                                                                              constraints.maxHeight *
                                                                              level.length,
                                                                      height: constraints
                                                                              .maxHeight /
                                                                          level
                                                                              .length,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: colors[
                                                                            block],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          2,
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
                                              },
                                            ),
                                            if (isEnded && !isPlaying) ...[
                                              Center(
                                                child: Text(
                                                  'Game Over',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.copyWith(
                                                        foreground: Paint()
                                                          ..color = Colors.white
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
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                    isExtended: true,
                                    onPressed: () {
                                      // print([isPlaying, isPaused, isEnded]);
                                      if (isPaused) {
                                        play();
                                      } else if (isPlaying) {
                                        pause();
                                      } else {
                                        start();
                                      }
                                    },
                                    child: Text(
                                      isEnded
                                          ? 'Restart'
                                          : isPaused
                                              ? 'Play'
                                              : isPlaying
                                                  ? 'Pause'
                                                  : 'Start',
                                    ),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () => move(AxisDirection.left),
                                    child: const Icon(Icons.arrow_left),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () => move(AxisDirection.right),
                                    child: const Icon(Icons.arrow_right),
                                  ),
                                  FloatingActionButton(
                                    onPressed: rotate,
                                    child: const Icon(Icons.rotate_right),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () =>
                                        move(AxisDirection.down, fall: true),
                                    child: const Icon(Icons.arrow_drop_down),
                                  ),
                                ]
                                    .map(
                                      (e) => Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: e,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              if (isCompleted) ...[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color:
                      Theme.of(context).colorScheme.surfaceTint.withOpacity(.5),
                ),
                Center(
                  child: Text(
                    'Game Paused\nTime to Study',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          foreground: Paint()
                            ..color = Colors.white
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.0,
                        ),
                  ),
                ),
                Center(
                  child: Text(
                    'Game Paused\nTime to Study',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
              SafeArea(
                child: BackButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Rotate
  void rotate() {
    if (!isPlaying || isEnded || isPaused || _currentBlock == null) {
      return;
    }
    final block = _currentBlock!;
    final newBlock = copyBlock(block);
    if (newBlock.rotation == newBlock.coordinates.length - 1) {
      newBlock.rotation = 0;
    } else {
      newBlock.rotation++;
    }
    place(block, remove: true);
    if (canPlace(newBlock)) {
      _currentBlock = newBlock;
      place(newBlock);
    } else {
      place(block);
    }
  }
}
