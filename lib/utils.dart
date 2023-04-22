import 'package:flutter/material.dart';
import 'package:gameodoro/models/block.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferences =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

String getStudyStateName(StudyState sessionState) {
  switch (sessionState) {
    case StudyState.focus:
      return 'Focus';
    case StudyState.shortBreak:
      return 'Short Break';
    case StudyState.longBreak:
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
