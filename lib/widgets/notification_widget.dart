import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/home_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/providers/tune.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget({
    required this.state,
    required WidgetRef ref,
    super.key,
  }) {
    final tune = ref.read(
      tuneProvider.select(
        (value) => value.firstWhere((element) => element.selected),
      ),
    );
    if (tune.path.isNotEmpty) {
      ref.read(audioplayer)
        ..stop()
        ..play(AssetSource(tune.path));
    }
  }

  final SessionState state;

  final titles = {
    SessionState.focus: 'Time to focus',
    SessionState.shortBreak: 'Time for a short break',
    SessionState.longBreak: 'Time for a longer break',
  };
  final texts = {
    SessionState.focus:
        "Welcome back! You're ready to tackle your next task. Let's get started and make the most of the next session!",
    SessionState.shortBreak:
        "Time flies when you're focused! Take a quick break to stretch your legs and give your brain a rest. You'll come back even sharper and more productive.",
    SessionState.longBreak:
        "You've earned a well-deserved break. Take some time to recharge and come back ready to crush your next set of tasks!",
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Center(
      child: SizedBox(
        width: 480,
        child: Card(
          elevation: 24,
          child: ListTile(
            title: Text(titles[state]!, style: textTheme.titleMedium),
            subtitle: Column(
              children: [
                Text(texts[state]!, style: textTheme.bodyMedium),
                if (state != SessionState.focus)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context)
                          .pushReplacementNamed(HomePage.route);
                      Navigator.of(context).pushNamed(GamesPage.route);
                    },
                    child: const Text('Open games'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
