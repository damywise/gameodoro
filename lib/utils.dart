import 'package:flutter/material.dart';
import 'package:gameodoro/providers/session.dart';

String getStudyStateName(StudyState studyState) {
  switch (studyState) {
    case StudyState.focus:
      return 'Focus';
    case StudyState.shortBreak:
      return 'Short Break';
    case StudyState.longBreak:
      return 'Long Break';
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
