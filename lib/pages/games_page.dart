import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gameodoro/constants.dart';
import 'package:gameodoro/pages/games/tetris_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/gameodoro_logo.dart';

/// Contains a curated selection of games
class GamesPage extends StatelessWidget {
  /// Contains a curated selection of games
  const GamesPage({super.key});

  static const route = '/games';

  @override
  Widget build(BuildContext context) {
    final games = [
      (title: 'Tetris', path: 'assets/shot_tetris.png', page: TetrisPage.route),
    ];
    const cardWidth = 240.0;
    const cardHeight = 380.0;
    // final rows = MediaQuery.of(context).size.width / cardWidth;
    // final columns = games.length / rows;

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceVariant,
      body: SafeArea(
        minimum: safeAreaMinimumEdgeInsets,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Games'),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Logo(
                  showText: false,
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    max(1, MediaQuery.of(context).size.width ~/ cardWidth),
              ),
              children: [
                ...games.map(
                  (game) => AspectRatio(
                    aspectRatio: cardWidth / cardHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Card(
                            color: context.colorScheme.onSurfaceVariant,
                            elevation: 12,
                            child: ShaderMask(
                              blendMode: BlendMode.dstIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(.8),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [.65, .7, .85],
                                ).createShader(bounds);
                              },
                              child: AspectRatio(
                                aspectRatio: cardWidth / cardHeight,
                                child: Container(
                                  width: cardWidth,
                                  height: cardHeight,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color:
                                          context.colorScheme.onSurfaceVariant,
                                    ),
                                    color:
                                        context.colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.asset(
                                      game.path,
                                      width: cardWidth,
                                      height: cardHeight,
                                      fit: BoxFit.fitWidth,
                                      frameBuilder: (
                                        context,
                                        child,
                                        frame,
                                        wasSynchronouslyLoaded,
                                      ) =>
                                          frame != null
                                              ? child
                                              : const Align(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Text(
                                      game.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                        shadows: [
                                          const Shadow(
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(game.page);
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
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('More games are coming soon!'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
