import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/home_page.dart';
import 'package:gameodoro/providers/session.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/gameodoro_logo.dart';
import 'package:gameodoro/widgets/notification_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  static const route = '/onboarding';

  static const descriptions = [
    'Gameodoro is a fun and effective tool for learning. With built-in timers and pomodoro techniques, users can easily set up learning time using time settings. No more boring study sessions!',
    'Gameodoro also provides a to-do list to organize your tasks. With this feature, you can easily keep track of your daily duties and stay on top of your game.',
    'You can play games provided by Gameodoro during recess to improve your study mood.',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// notif
    ref.listen(sessionProvider, (previous, next) {
      // Notification is only triggered when changing session with timer, not
      // manually.
      // Also, notification can be disabled
      if (next.sessionState != previous?.sessionState &&
          next.elapsed + 200 >= (previous?.duration.inMilliseconds ?? 0) &&
          (ref.read(sharedPreferences).getBool('enablenotification') ?? true)) {
        showTopSnackBar(
          Overlay.of(context),
          SafeArea(
            minimum: safeAreaMinimumEdgeInsets,
            child: NotificationWidget(
              key: Key(Random.secure().nextInt(100000).toString()),
              ref: ref,
              state: next.sessionState,
            ),
          ),
          dismissDirection: const [
            DismissDirection.up,
            DismissDirection.horizontal
          ],
          dismissType: DismissType.onSwipe,
        );
      }
    });

    final controller = usePageController();
    final buttonText = useState('Next');
    final index = useState(0);
    useEffect(
      () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
        controller.addListener(() {
          index.value = (controller.page ?? 0).round();
          buttonText.value = index.value < 2 ? 'Next' : 'Take me to Gameodoro!';
        });

        return null;
      },
      [],
    );
    const cardSize = 240.0;
    const images = [
      'assets/img1.png',
      'assets/img2.png',
      'assets/img3.png',
    ];
    final topMargin = MediaQuery.of(context).size.height / 2 - cardSize;

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Stack(
          children: [
            PageView(
              controller: controller,
              children: [
                buildPage(
                  context,
                  cardSize,
                  descriptions[0],
                  topMargin,
                  images[0],
                ),
                buildPage(
                  context,
                  cardSize,
                  descriptions[1],
                  topMargin,
                  images[1],
                ),
                buildPage(
                  context,
                  cardSize,
                  descriptions[2],
                  topMargin,
                  images[2],
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Logo(),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: topMargin + cardSize + 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildIndicator(selected: index.value == 0),
                    buildIndicator(selected: index.value == 1),
                    buildIndicator(selected: index.value == 2),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                FilledButton(
                  onPressed: () {
                    buttonText.value =
                        index.value < 2 ? 'Next' : 'Take me to Gameodoro!';
                    if (index.value < 2) {
                      controller.animateToPage(
                        index.value + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutCubic,
                      );
                    } else {
                      Navigator.of(context).pushReplacementNamed(
                        HomePage.route,
                      );
                    }
                  },
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(buttonText.value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildPage(
    BuildContext context,
    double cardSize,
    String description,
    double topMargin,
    String imagePath,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(
              height: topMargin,
            ),
            Stack(
              children: [
                Card(
                  color: context.colorScheme.primary,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: context.colorScheme.primaryContainer,
                      width: 4,
                    ),
                  ),
                  elevation: 24,
                  child: SizedBox(
                    width: cardSize,
                    height: cardSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 12),
                  child: Image.asset(
                    imagePath,
                    height: cardSize - 24,
                    width: cardSize - 56,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 128,
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: cardSize + 64,
              child: Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator({required bool selected}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 200),
        elevation: 1,
        color: Colors.white.withOpacity(selected ? 1 : .5),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            width: selected ? 48 : 12,
            height: 12,
          ),
        ),
      ),
    );
  }
}
