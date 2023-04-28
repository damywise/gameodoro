import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/main_page.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }
  runApp(
    ProviderScope(
      overrides: [sharedPreferences.overrideWithValue(prefs)],
      child: const Main(),
    ),
  );
}

///
class Main extends HookConsumerWidget {
  ///
  const Main({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstTimeOpen = ref.read(sharedPreferences).getBool('firstopen');

    return InAppNotification(
      child: MaterialApp(
        title: 'Gameodoro',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.redAccent,
            brightness: usePlatformBrightness(),
            // brightness: Brightness.light,
            // brightness: Brightness.dark,
          ),
        ),
        // home: const MainPage(title: 'Gameodoro'),
        home: firstTimeOpen ?? true
            ? const OnboardingPage()
            : const MainPage(title: 'Gameodoro'),
      ),
    );
  }
}
