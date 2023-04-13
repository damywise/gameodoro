import 'package:flutter/material.dart';
import 'package:gameodoro/pages/games/tetris.dart';

/// Contains a curated selection of games
class GamesPage extends StatelessWidget {
  /// Contains a curated selection of games
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final games = {
      'Tetris': const TetrisGame(),
    };
    const cardWidth = 120.0;
    // final rows = MediaQuery.of(context).size.width / cardWidth;
    // final columns = games.length / rows;

    return Column(
      children: games
          .map(
            (key, value) => MapEntry(
              '',
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      elevation: 1,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: ShaderMask(
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
                                  stops: const [.5, .6, .8],
                                ).createShader(bounds);
                              },
                              child: Container(
                                width: cardWidth,
                                height: cardWidth,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
                                FilledButton(
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    elevation: MaterialStateProperty.all(3),
                                    shape: MaterialStateProperty.all(
                                      ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<Widget>(
                                        builder: (context) => value,
                                      ),
                                    );
                                  },
                                  child: const Text('Play'),
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
    );
  }
}
