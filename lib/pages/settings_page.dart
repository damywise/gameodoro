import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

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

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        children: [
          buildSlider(
            context,
            focusDuration,
            edit,
            'Focus',
            state: null,
          ),
          buildSlider(
            context,
            shortBreakDuration,
            edit,
            'Short Break',
            state: true,
          ),
          buildSlider(
            context,
            longBreakDuration,
            edit,
            'Long Break',
            state: false,
          ),
          const SizedBox(
            height: 32,
          ),
          Align(
            child: FilledButton.tonalIcon(
              onPressed: () => Navigator.of(context)
                ..pop()
                ..pushReplacement(
                  MaterialPageRoute<Widget>(
                    builder: (context) => const OnboardingPage(),
                  ),
                ),
              icon: const Icon(Icons.start),
              label: const Text('Go back to Onboarding'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlider(
    BuildContext context,
    Duration duration,
    void Function({
      Duration? longBreakDuration,
      Duration? shortBreakDuration,
      Duration? studyDuration,
    })
        edit,
    String title, {
    required bool? state,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16).copyWith(left: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Card(
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${getMinutes(duration) < 10 ? '0' : ''}${getMinutes(
                      duration,
                    )} : ${getSeconds(duration) < 10 ? '0' : ''}${getSeconds(duration)}',
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8).copyWith(left: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Minutes',
                      style: context.textTheme.labelLarge,
                    ),
                    Expanded(
                      child: Slider(
                        inactiveColor: context.colorScheme.onPrimary,
                        max: 60,
                        value: min(59, max(0, getMinutes(duration).toDouble())),
                        divisions: 60,
                        label: '${getMinutes(duration)} minutes',
                        onChanged: (value) {
                          final newDuration = Duration(
                            minutes: min(59, max(0, value.round())),
                            seconds: getSeconds(duration),
                          );
                          switch (state) {
                            case null:
                              edit(studyDuration: newDuration);
                              break;
                            case true:
                              edit(shortBreakDuration: newDuration);
                              break;
                            case false:
                              edit(longBreakDuration: newDuration);
                              break;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Seconds',
                      style: context.textTheme.labelLarge,
                    ),
                    Expanded(
                      child: Slider(
                        inactiveColor: context.colorScheme.onPrimary,
                        max: 60,
                        value: min(60, max(0, getSeconds(duration).toDouble())),
                        divisions: 60,
                        label: '${getSeconds(duration)} seconds',
                        onChanged: (value) {
                          final newDuration = Duration(
                            minutes: getMinutes(duration),
                            seconds: min(59, max(0, value.round())),
                          );
                          switch (state) {
                            case null:
                              edit(studyDuration: newDuration);
                              break;
                            case true:
                              edit(shortBreakDuration: newDuration);
                              break;
                            case false:
                              edit(longBreakDuration: newDuration);
                              break;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
