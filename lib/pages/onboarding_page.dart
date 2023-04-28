import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gameodoro/pages/main_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.read(sharedPreferences);
    final controller = usePageController();
    final buttonText = useState('Next');
    final index = useState(0);
    useEffect(
      () {
        controller.addListener(() {
          index.value = (controller.page ?? 0).round();
          buttonText.value = index.value < 2 ? 'Next' : 'Take me to Gameodoro!';
        });

        return null;
      },
      [],
    );
    const cardSize = 240.0;
    const descriptions = [
      'Gameodoro is a fun and effective tool for learning. With built-in timers and pomodoro techniques, users can easily set up learning time using time settings. No more boring study sessions!',
      'Gameodoro also provides a to-do list to organize your tasks. With this feature, you can easily keep track of your daily duties and stay on top of your game.',
      'You can play games provided by Gameodoro during recess to improve your study mood.',
    ];
    const images = [
      'assets/img1.png',
      'assets/img2.png',
      'assets/img3.png',
    ];
    final topMargin = MediaQuery.of(context).size.height / 2 - cardSize;

    return Scaffold(
      body: Stack(
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
          Align(
            alignment: Alignment.topLeft,
            child: Tooltip(
              message: 'Gameodoro',
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/logo.png',
                  height: 48,
                ),
              ),
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
                    prefs.setBool('firstopen', false);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<Widget>(
                        builder: (context) =>
                            const MainPage(title: 'Gameodoro'),
                      ),
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
      backgroundColor: context.colorScheme.surfaceVariant,
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
