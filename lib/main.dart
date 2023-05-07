import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/full_screen_page.dart';
import 'package:gameodoro/pages/games/tetris_page.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/main_page.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/pages/settings_page.dart';
import 'package:gameodoro/pages/to_do_list_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top],
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

    return MaterialApp(
      title: 'Gameodoro',
      color: context.colorScheme.surfaceVariant,
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
      routes: {
        OnboardingPage.route: (context) => const OnboardingPage(),
        MainPage.route: (context) => const MainPage(),
        // in game
        FullScreenPage.route: (context) => const FullScreenPage(),
        SettingsPage.route: (context) => const SettingsPage(),
        ToDoListPage.route: (context) => const ToDoListPage(),
        GamesPage.route: (context) => const GamesPage(),
        // games
        TetrisPage.route: (context) => const TetrisPage(),
      },
      initialRoute:
          firstTimeOpen ?? true ? OnboardingPage.route : MainPage.route,
    );
  }
}
