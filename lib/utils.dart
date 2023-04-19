import 'package:flutter/material.dart';
import 'package:gameodoro/providers/session.dart';

void getStudyStateName(StudyState studyState, ValueNotifier<String> stateText) {
  switch (studyState) {
    case StudyState.focus:
      stateText.value = 'Focus';
      break;
    case StudyState.shortBreak:
      stateText.value = 'Short Break';
      break;
    case StudyState.longBreak:
      stateText.value = 'Long Break';
      break;
  }
}

class Block {
  Block(this.coordinates, this.index);

  List<int> position = [0, 0];
  final List<List<List<int>>> coordinates;
  final int index;
  int rotation = 0;
}

Block copyBlock(Block block) {
  final newBlock = Block(block.coordinates, block.index)
    ..rotation = block.rotation
    ..position = [...block.position];
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
