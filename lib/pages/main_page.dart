import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/home_page.dart';

class MainPage extends HookWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final selectedPage = useState(0);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer_sharp),
            selectedIcon: Icon(Icons.timer_rounded),
            label: 'Pomodoro',
          ),
          NavigationDestination(
            icon: Icon(Icons.videogame_asset),
            selectedIcon: Icon(Icons.videogame_asset),
            label: 'Games',
          ),
        ],
        selectedIndex: selectedPage.value,
        onDestinationSelected: (value) {
          selectedPage.value = value;
        },
      ),
      body: <Widget>[const HomePage(), const GamesPage()]
          // .map((e) => Platform.isAndroid ? SafeArea(child: e) : e)
          .toList()[selectedPage.value],
    );
  }
}
