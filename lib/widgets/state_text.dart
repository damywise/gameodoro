import 'package:flutter/material.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StateText extends HookConsumerWidget {
  const StateText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(
      sessionProvider.select((value) => value.studyState),
    );
    return Hero(
      tag: 'session state text',
      child: Text(
        getStudyStateName(sessionState),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
