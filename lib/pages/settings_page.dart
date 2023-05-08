import 'package:flutter/material.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/timer_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const TimerPicker(),
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
}
