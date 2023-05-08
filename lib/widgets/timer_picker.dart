import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerPicker extends HookConsumerWidget {
  const TimerPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusDuration = ref.watch(
      sessionProvider.select((value) => value.data.studyDuration),
    );
    final shortBreakDuration = ref.watch(
      sessionProvider.select((value) => value.data.shortBreakDuration),
    );
    final longBreakDuration = ref.watch(
      sessionProvider.select((value) => value.data.longBreakDuration),
    );
    final edit = ref.watch(sessionProvider.notifier).edit;

    final tabController = useTabController(initialLength: 3);
    return Column(
      children: [
        TabBar(
          tabs: const [
            Text('Focus'),
            Text('Short Break'),
            Text('Long Break'),
          ],
          controller: tabController,
        ),
        SizedBox(
          height: 240,
          child: TabBarView(
            controller: tabController,
            children: [
              (null, 'Focus', focusDuration),
              (true, 'Short Break', shortBreakDuration),
              (false, 'Long Break', longBreakDuration)
            ].map((e) {
              final (state, title, duration) = e;
              return buildTimerPicker(
                context,
                duration,
                edit,
                title,
                state: state,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildTimerPicker(
    BuildContext context,
    Duration duration,
    void Function({
      Duration? longBreakDuration,
      Duration? shortBreakDuration,
      Duration? focusDuration,
    }) edit,
    String title, {
    required bool? state,
  }) {
    return CupertinoTimerPicker(
      initialTimerDuration: duration,
      onTimerDurationChanged: (value) {
        edit(
          focusDuration: state == null ? value : null,
          shortBreakDuration: state ?? false ? value : null,
          longBreakDuration: state == false ? value : null,
        );
      },
    );
  }

  int getHours(Duration focusDuration) {
    final minutes = focusDuration.inHours;

    return minutes;
  }

  int getMinutes(Duration focusDuration) {
    final minutes = focusDuration.inMinutes % 61;

    return minutes;
  }

  int getSeconds(Duration focusDuration) {
    final seconds = focusDuration.inSeconds % 60;

    return seconds;
  }
}
