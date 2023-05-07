import 'package:flutter/material.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StateText extends HookConsumerWidget {
  const StateText({super.key, this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(
      sessionProvider.select((value) => value.sessionState),
    );

    return Hero(
      tag: 'session state text',
      child: Text(
        getStudyStateName(sessionState),
        style: large
            ? context.textTheme.headlineLarge
            : context.textTheme.titleLarge,
      ),
    );
  }
}
