import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/models/block.dart';
import 'package:gameodoro/models/tetris_data.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tetris.g.dart';

// TODO(damywise): put data in shared references and load when build

@riverpod
class Tetris extends _$Tetris {
  @override
  TetrisData build() {
    _prefs = ref.read(sharedPreferences);

    return TetrisData(
      level: List.filled(18, List.filled(10, blocks.length)),
      currentBlock: null,
      isPlaying: false,
      isPaused: false,
      isGameover: false,
    );
  }

  late SharedPreferences _prefs;

  void dispose() {
    _timer.cancel();
  }

  var _timer = Timer(Duration.zero, () {
    return;
  });

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final data = TetrisData.fromJson(
      json.decode(_prefs.getString('tetris') ?? '') as Map<String, dynamic>,
    );
    state = data.level.isNotEmpty ? data : state;
  }

  Future<void> save() async {
    await _prefs.setString('tetris', json.encode(state.toJson()));
  }

  void start() {
    state = state.copyWith(
      level: List.filled(18, List.filled(10, blocks.length)),
      isPlaying: true,
      isPaused: false,
      isGameover: false,
    );
    startGame();
  }

  void play() {
    state = state.copyWith(
      isPlaying: true,
      isPaused: false,
    );
  }

  void pause() {
    state = state.copyWith(
      isPaused: true,
    );
  }

  void end() {
    state = state.copyWith(
      isPlaying: false,
      isGameover: true,
    );
  }

  void place(Block block, {bool lock = false, bool remove = false}) {
    final newLevel = [...state.level];

    final blockCoordinate = block.coordinates[block.rotation];
    for (var i = 0; i < blockCoordinate.length; i++) {
      for (var j = 0; j < blockCoordinate[i].length; j++) {
        final cell = blockCoordinate[i][j] == 1;
        if (!cell) continue;

        final posX = block.position[1] + i;
        final posY = block.position[0] + j;

        /// changes the block accordingly
        /// if removed, change to 7 (background)
        /// if locked, change to 8 (static blocks)
        /// else (is moving), change to the current block
        final levelY = [...newLevel[posX]];
        levelY[posY] = switch ((remove, lock)) {
          (true, _) => 7,
          (_, _) => block.index
        };
        newLevel[posX] = levelY;
      }
    }
    state = state.copyWith(level: newLevel);
  }

  bool choosePiece() {
    if (state.currentBlock != null) place(state.currentBlock!, lock: true);
    cleanLines();
    final level = state.level;
    if (level.first.where((element) => element != 7).isNotEmpty) {
      return false;
    }
    final index = Random().nextInt(blocks.length);
    // const index = 0;
    final block = blocks[index];
    var newBlock = copyBlock(block);

    var i = 0;
    do {
      i++;
      if (index > 0) {
        newBlock = newBlock
            .copyWith(position: [Random().nextInt(level.first.length - 1), 0]);
      }
    } while (!_canPlace(newBlock) && i < level.first.length);

    if (_canPlace(newBlock)) {
      place(newBlock);
    }
    state = state.copyWith(currentBlock: newBlock);

    return true;
  }

  /// check if the block with its rotation and its coordinate can be placed
  bool _canPlace(Block block) {
    final level = state.level;
    final blockCoordinate = block.coordinates[block.rotation];

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

        allTrues.add(level[posX][posY] == blocks.length && cell);
      }
    }

    if (!allTrues.contains(false)) {
      return true;
    }

    return false;
  }

  bool move(AxisDirection direction, {bool fall = false, bool noLock = false}) {
    final sessionState =
        ref.read(sessionProvider.select((value) => value.sessionState));
    final isFocusing = sessionState == SessionState.focus;
    if ((!state.isPlaying && state.isGameover) || isFocusing) {
      return false;
    }
    if (state.isPaused) {
      return true;
    }
    if (state.currentBlock == null) return false;
    final block = state.currentBlock!;
    if (fall) {
      do {
        move(AxisDirection.down, noLock: true);
      } while (move(AxisDirection.down, noLock: true));

      return false;
    }
    var newBlock = copyBlock(block);

    if (direction == AxisDirection.down) {
      newBlock = newBlock
          .copyWith(position: [newBlock.position[0], newBlock.position[1] + 1]);
    }
    if (direction == AxisDirection.left) {
      newBlock = newBlock
          .copyWith(position: [newBlock.position[0] - 1, newBlock.position[1]]);
    }
    if (direction == AxisDirection.right) {
      newBlock = newBlock
          .copyWith(position: [newBlock.position[0] + 1, newBlock.position[1]]);
    }

    place(block, remove: true);
    if (_canPlace(newBlock)) {
      place(newBlock);
      state = state.copyWith(currentBlock: newBlock);

      return true;
    } else if (direction == AxisDirection.down) {
      place(block, lock: !noLock);
    } else {
      place(block);
    }

    return false;
  }

  /// Rotate
  void rotate() {
    final sessionState =
        ref.read(sessionProvider.select((value) => value.sessionState));
    final isStudying = sessionState == SessionState.focus;
    if (!state.isPlaying ||
        state.isGameover ||
        state.isPaused ||
        state.currentBlock == null ||
        isStudying) {
      return;
    }
    final block = state.currentBlock!;
    var newBlock = copyBlock(block);
    newBlock = newBlock.copyWith(
      rotation: newBlock.rotation == newBlock.coordinates.length - 1
          ? 0
          : newBlock.rotation + 1,
    );
    place(block, remove: true);
    if (_canPlace(newBlock)) {
      state = state.copyWith(currentBlock: newBlock);
      place(newBlock);
    } else {
      place(block);
    }
  }

  void startGame() {
    const duration = Duration(milliseconds: 500);
    final isNotStuck = choosePiece();
    _timer.cancel();
    _timer = Timer.periodic(duration, (timer) {
      _tick(isNotStuck, timer);
    });
  }

  void _tick(bool isNotStuck, Timer timer) {
    var newNotStuck = isNotStuck;
    final sessionState =
        ref.read(sessionProvider.select((value) => value.sessionState));
    final isCompleted = sessionState == SessionState.focus;

    if ((!state.isPaused || state.isGameover || !state.isPlaying) &&
        !isCompleted &&
        !move(AxisDirection.down)) {
      newNotStuck = choosePiece();
      if (!newNotStuck) {
        state = state.copyWith(
          isPlaying: false,
          isGameover: true,
        );
        timer.cancel();
      }
    }
  }

  void cleanLines() {
    var level = [...state.level];
    var i = -1;
    final cleared = <int>[];
    for (final row in level) {
      i++;
      if (row.every((element) => element != 7)) {
        cleared.add(i);
      }
    }
    for (final j in cleared) {
      level.removeAt(j);
      level = [
        List.filled(level.first.length, 7),
        ...level,
      ];
    }
    if (cleared.isNotEmpty) state = state.copyWith(level: level);
  }
}
