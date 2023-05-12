import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/full_screen_page.dart';
import 'package:gameodoro/pages/games/tetris_page.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/home_page.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/pages/settings_page.dart';
import 'package:gameodoro/pages/to_do_list_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

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
      debugShowCheckedModeBanner: false,
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
      builder: (context, child) => _BuilderWidget(child: child),
      routes: {
        // initial route
        OnboardingPage.route: (context) => const OnboardingPage(),
        HomePage.route: (context) => const HomePage(),
        // accessible through home page
        FullScreenPage.route: (context) => const FullScreenPage(),
        SettingsPage.route: (context) => const SettingsPage(),
        ToDoListPage.route: (context) => const ToDoListPage(),
        GamesPage.route: (context) => const GamesPage(),
        // games
        TetrisPage.route: (context) => const TetrisPage(),
      },
      initialRoute:
          firstTimeOpen ?? true ? OnboardingPage.route : HomePage.route,
    );
  }
}

class _BuilderWidget extends HookConsumerWidget {
  const _BuilderWidget({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) => Stack(
          children: [
            child ?? const SizedBox.shrink(),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: ref.watch(tutorialRunning)
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  minimum: safeAreaMinimumEdgeInsets,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: FilledButton.icon(
                      onPressed: () {
                        ShowCaseWidget.of(context).dismiss();
                        ref.read(tutorialRunning.notifier).state = false;
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Skip Tutorial'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
