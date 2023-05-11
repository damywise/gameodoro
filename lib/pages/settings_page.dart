import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/gameodoro_logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enableNotification = useState(
      ref.read(sharedPreferences).getBool('enablenotification') ?? true,
    );
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Settings'),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Logo(
                  showLogo: false,
                ),
              )
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16).copyWith(top: 0),
            children: [
              SwitchListTile(
                title: const Text('Notification'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                value: enableNotification.value,
                onChanged: (value) {
                  ref.read(sharedPreferences).setBool(
                        'enablenotification',
                        value,
                      );
                  enableNotification.value = value;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                child: FilledButton.icon(
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
