import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gameodoro/models/block.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferences =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final tutorialRunning = StateProvider<bool>((ref) => false);
final audioplayer = Provider<AudioPlayer>((ref) => AudioPlayer());

String getStudyStateName(SessionState sessionState) {
  switch (sessionState) {
    case SessionState.focus:
      return 'Focus';
    case SessionState.shortBreak:
      return 'Short Break';
    case SessionState.longBreak:
      return 'Long Break';
  }
}

Block copyBlock(Block block) {
  final newBlock = Block(
    block.coordinates,
    block.index,
    [...block.position],
    block.rotation,
  );

  return newBlock;
}

List<Color> getColors() {
  return [
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.orangeAccent,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.grey.withOpacity(.2),
    Colors.grey.shade700,
  ];
}

extension ContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
