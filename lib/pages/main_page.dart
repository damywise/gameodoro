import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/home_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/providers/tune.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_notification/in_app_notification.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = useMemoized(AudioPlayer.new);
    const titles = {
      SessionState.focus: 'Time to focus',
      SessionState.shortBreak: 'Time for a short break',
      SessionState.longBreak: 'Time for a longer break',
    };
    const texts = {
      SessionState.focus:
          "Welcome back! You're ready to tackle your next task. Let's get started and make the most of the next session!",
      SessionState.shortBreak:
          "Time flies when you're focused! Take a quick break to stretch your legs and give your brain a rest. You'll come back even sharper and more productive.",
      SessionState.longBreak:
          "You've earned a well-deserved break. Take some time to recharge and come back ready to crush your next set of tasks!",
    };
    ref.listen(sessionProvider, (previous, next) {
      if (next.sessionState != previous?.sessionState) {
        player.stop();
        final tune = ref.read(
          tuneProvider.select(
            (value) => value.firstWhere((element) => element.selected),
          ),
        );
        if (tune.path.isNotEmpty) {
          player.play(AssetSource(tune.path));
        }
        InAppNotification.show(
          child: NotificationWidget(
          key: Key(Random.secure().nextInt(100000).toString()),
            title: titles[next.sessionState]!,
            text: texts[next.sessionState]!,
          ),
          context: context,
        );
      }
    });

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: const HomePage(),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    required this.text,
    required this.title,
    super.key,
  });

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Center(
      child: SizedBox(
        width: 480,
        child: Card(
          elevation: 24,
          child: ListTile(
            title: Text(title, style: textTheme.titleMedium),
            subtitle: Text(text, style: textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }
}
