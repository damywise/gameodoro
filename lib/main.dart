import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/main_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }
  runApp(const ProviderScope(child: Main()));
}

///
class Main extends HookWidget {
  ///
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPage = useState(0);
    return MaterialApp(
      title: 'Gameodoro',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MainPage(title: 'Gameodoro'),
    );
  }
}
