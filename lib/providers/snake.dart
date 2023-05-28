import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart';
import 'package:gameodoro/models/snake_data.dart';
import 'package:gameodoro/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'snake.g.dart';

const duration = Duration(milliseconds: 300);

@riverpod
class Snake extends _$Snake {
  @override
  SnakeData build() {
    _prefs = ref.read(sharedPreferences);

    return SnakeData(
      level: List.filled(10, List.filled(18, 0)),
      pos: [],
      length: 0,
      direction: AxisDirection.down,
      isPlaying: false,
      isPaused: false,
      isGameover: false,
    );
  }

  late final SharedPreferences _prefs;

  var _timer = Timer(Duration.zero, () {
    return;
  });

  var newDirection = AxisDirection.down;

  void start() {
    final newSnake = SnakePos(
      x: Random().nextInt(9),
      y: Random().nextInt(17),
    );
    state = state.copyWith(
      level: List.filled(10, List.filled(18, 0)),
      pos: [
        newSnake,
        SnakePos(x: newSnake.x, y: newSnake.y - 1),
      ],
      length: 0,
      direction: AxisDirection.down,
      isPlaying: true,
      isPaused: false,
      isGameover: false,
    );
    startGame();
  }

  void play() {
    startGame();
    state = state.copyWith(
      isPlaying: true,
      isPaused: false,
    );
  }

  void pause() {
    _timer.cancel();
    state = state.copyWith(
      isPaused: true,
    );
  }

  void resume() {
    state = state.copyWith(
      isPaused: false,
    );
  }

  void end() {
    _timer.cancel();
    state = state.copyWith(
      isPlaying: false,
      isGameover: true,
    );
  }

  void _tick() {
    // handle direction
    state = state.copyWith(
      direction: switch (state.direction) {
        AxisDirection.down when newDirection == AxisDirection.up =>
          AxisDirection.down,
        AxisDirection.up when newDirection == AxisDirection.down =>
          AxisDirection.up,
        AxisDirection.right when newDirection == AxisDirection.left =>
          AxisDirection.right,
        AxisDirection.left when newDirection == AxisDirection.right =>
          AxisDirection.left,
        _ => newDirection,
      },
    );

    final newPos = [
      SnakePos(
        x: state.pos.first.x +
            switch (state.direction) {
              // When hit wall, start from the left
              AxisDirection.right
                  when state.pos.first.x == state.level.length - 1 =>
                -9,
              AxisDirection.right => 1,
              // When hit wall, start from the right
              AxisDirection.left
                  when state.pos.first.x == 0 =>
                9,
              AxisDirection.left => -1,
              _ => 0,
            },
        y: state.pos.first.y +
            switch (state.direction) {
              // When hit wall, start from the top
              AxisDirection.down
                  when state.pos.first.y == state.level[0].length - 1 =>
                -17,
              AxisDirection.down => 1,
              // When hit wall, start from the bottom
              AxisDirection.up
                  when state.pos.first.y == 0 =>
                17,
              AxisDirection.up => -1,
              _ => 0,
            },
      ),
    ];

    if (state.level[newPos.first.x][newPos.first.y] == 1) {
      end();
    }

    if (state.level[newPos.first.x][newPos.first.y] == 2) {
      newPos.addAll(state.pos);
    } else {
      newPos.addAll([...state.pos]..removeLast());
    }

    state = state.copyWith(
      pos: newPos,
    );

    _drawSnake(food: state.level[state.pos.first.x][state.pos.first.y] == 2);

    if (!state.level.flattened.contains(2) && !state.isGameover) {
      _spawnFood();
    }
  }

  void _spawnFood() {
    final newLevel = [...state.level];
    while (true) {
      final newX = Random().nextInt(9);
      final newY = Random().nextInt(17);
      if (newLevel[newX][newY] == 0) {
        newLevel[newX] = [...newLevel[newX]]..[newY] = 2;
        break;
      }
    }
    state = state.copyWith(level: newLevel);
  }

  void _drawSnake({required bool food}) {
    final newLevel = [
      ...state.level.map(
        (e) => [
          ...e.map((e) => e == 2 ? 2 : 0),
        ],
      )
    ];
    state.pos.forEachIndexed((index, element) {
      newLevel[element.x] = [...newLevel[element.x]]..[element.y] = 1;
    });
    state = state.copyWith(level: newLevel);
  }

  void startGame() {
    _drawSnake(food: false);
    _timer.cancel();
    _timer = Timer.periodic(
      duration,
      (_) => _tick(),
    );
  }

  void move(AxisDirection direction) {
    // set temporary direction
    newDirection = switch (state.direction) {
      AxisDirection.down when direction == AxisDirection.up =>
        AxisDirection.down,
      AxisDirection.up when direction == AxisDirection.down => AxisDirection.up,
      AxisDirection.right when direction == AxisDirection.left =>
        AxisDirection.right,
      AxisDirection.left when direction == AxisDirection.right =>
        AxisDirection.left,
      _ => direction,
    };
    newDirection = direction;
  }

  void dispose() {
    _timer.cancel();
  }
}
