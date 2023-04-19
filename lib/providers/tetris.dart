import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tetris.g.dart';

part 'tetris.freezed.dart';

// Todo(damywise): put data in shared references and load when build

@riverpod
class Tetris extends _$Tetris {
  @override
  TetrisData build() {
    return TetrisData(
      level: List.filled(18, List.filled(10, blocks.length)),
      currentBlock: null,
      isPlaying: false,
      isPaused: false,
      isGameover: false,
    );
  }

  void dispose() {
    _timer.cancel();
  }

  var _timer = Timer(Duration.zero, () {});

  void start() {
    print('test');
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

  void place(Block block, {bool bottom = false, bool remove = false}) {
    final newLevel = [...state.level];

    final blockCoordinate = block.coordinates[block.rotation];
    for (var i = 0; i < blockCoordinate.length; i++) {
      for (var j = 0; j < blockCoordinate[i].length; j++) {
        final cell = blockCoordinate[i][j] == 1;
        if (!cell) continue;

        final posX = block.position[1] + i;
        final posY = block.position[0] + j;

        final levelY = [...newLevel[posX]];
        levelY[posY] = remove
            ? 7
            : bottom
                ? 8
                : block.index;
        newLevel[posX] = levelY;
      }
    }
    state = state.copyWith(level: newLevel);
  }

  bool choosePiece() {
    final level = state.level;
    if (level.first.contains(8)) {
      return false;
    }
    final index = Random().nextInt(blocks.length);
    // const index = 0;
    final block = blocks[index];
    final newBlock = copyBlock(block);

    var i = 0;
    do {
      i++;
      if (index > 0) {
        newBlock.position = [Random().nextInt(level.first.length - 1), 0];
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

  bool move(AxisDirection direction, {bool fall = false}) {
    final studyState =
        ref.read(sessionProvider.select((value) => value.studyState));
    final isFocusing = studyState == StudyState.focus;
    if ((!state.isPlaying && state.isGameover) || isFocusing) {
      return false;
    }
    if (state.isPaused) {
      return true;
    }
    if (state.currentBlock == null) return false;
    final block = state.currentBlock!;
    if (fall) {
      while (move(AxisDirection.down)) {}
      return false;
    }
    final newBlock = copyBlock(block);

    if (direction == AxisDirection.down) newBlock.position[1]++;
    if (direction == AxisDirection.left) newBlock.position[0]--;
    if (direction == AxisDirection.right) newBlock.position[0]++;

    place(block, remove: true);
    if (_canPlace(newBlock)) {
      place(newBlock);
      state = state.copyWith(currentBlock: newBlock);
      return true;
    } else if (direction == AxisDirection.down) {
      place(block, bottom: true);
    } else {
      place(block);
    }
    return false;
  }

  /// Rotate
  void rotate() {
    final studyState =
        ref.watch(sessionProvider.select((value) => value.studyState));
    final isCompleted = studyState == StudyState.focus;
    if (!state.isPlaying ||
        state.isGameover ||
        state.isPaused ||
        state.currentBlock == null ||
        isCompleted) {
      return;
    }
    final block = state.currentBlock!;
    final newBlock = copyBlock(block);
    if (newBlock.rotation == newBlock.coordinates.length - 1) {
      newBlock.rotation = 0;
    } else {
      newBlock.rotation++;
    }
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
    print('test');
    final studyState =
        ref.read(sessionProvider.select((value) => value.studyState));
    final isCompleted = studyState == StudyState.focus;

    if ((!state.isPaused || state.isGameover || !state.isPlaying) &&
        !isCompleted) {
      var level = [...state.level];
      if (!move(AxisDirection.down)) {
        /// clear row and fall
        var i = -1;
        final cleared = <int>[];
        for (final row in level) {
          i++;
          if (row.every((element) => element == 8)) {
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
  }
}

@freezed
class TetrisData with _$TetrisData {
  const factory TetrisData({
    required List<List<int>> level,
    required Block? currentBlock,
    required bool isPlaying,
    required bool isPaused,
    required bool isGameover,
  }) = _TetrisData;
}
