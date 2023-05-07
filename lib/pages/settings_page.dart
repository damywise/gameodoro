import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

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

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Settings'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16).copyWith(top: 0),
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
              const SizedBox(
                height: 32,
              ),
              Align(
                child: FilledButton.tonalIcon(
                  onPressed: () => Navigator.of(context)
                    ..pop()
                    ..pushReplacementNamed(
                      OnboardingPage.route,
                    ),
                  icon: const Icon(Icons.start),
                  label: const Text('Go back to Onboarding'),
                ),
              ),
            ],
          ),
        ),
      ),
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
