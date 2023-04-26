import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/main_page.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  Future<void> asyncInit(WidgetRef ref) async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      asyncInit(ref);
      return null;
    });
    return MaterialApp(
      title: 'Gameodoro',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          brightness: usePlatformBrightness(),
        ),
      ),
      // home: const MainPage(title: 'Gameodoro'),
      home: const OnboardingPage(),
    );
  }
}
