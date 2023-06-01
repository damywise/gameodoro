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
      sessionProvider.select((value) => value.data.focusDuration),
    );
    final shortBreakDuration = ref.watch(
      sessionProvider.select((value) => value.data.shortBreakDuration),
    );
    final longBreakDuration = ref.watch(
      sessionProvider.select((value) => value.data.longBreakDuration),
    );
    final edit = ref.watch(sessionProvider.notifier).edit;

    final tabController = useTabController(initialLength: 3);
    return SizedBox(
      height: 240 * 2,
      child: ListView(
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
                return _buildTimerPicker(
                  context,
                  duration,
                  edit,
                  title,
                  state: state,
                );
              }).toList(),
            ),
          ),
          TextButton(
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Reset All Timers'),
                content: const Text('Are you sure you want to reset all timers?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () {
                      ref.read(sessionProvider.notifier).defaultSettings();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Reset All Timers'),
                  ),
                ],
              ),
            ),
            child: const Text('Reset to default settings'),
          )
        ],
      ),
    );
  }

  Widget _buildTimerPicker(
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
    return Builder(
      builder: (context) {
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
