import 'package:flutter/material.dart';
import 'package:gameodoro/pages/games/tetris_page.dart';

/// Contains a curated selection of games
class GamesPage extends StatelessWidget {
  /// Contains a curated selection of games
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final games = {
      'Tetris': const TetrisPage(),
    };
    const cardWidth = 180.0;
    const cardHeight = 240.0;
    // final rows = MediaQuery.of(context).size.width / cardWidth;
    // final columns = games.length / rows;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
              child: BackButton(),
            ),
            Column(
              children: games
                  .map(
                    (key, value) => MapEntry(
                      '',
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: PhysicalModel(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                              elevation: 2,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ShaderMask(
                                    blendMode: BlendMode.dstIn,
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(.8),
                                          Colors.transparent
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [.65, .7, .85],
                                      ).createShader(bounds);
                                    },
                                    child: Container(
                                      width: cardWidth,
                                      height: cardHeight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Text(
                                          key,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute<Widget>(
                                                builder: (context) => value,
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Play',
                                            // style: Theme.of(context)
                                            //     .textTheme
                                            //     .labelLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
