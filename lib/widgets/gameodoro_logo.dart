import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.showText = true,
    this.showLogo = true,
  });

  final bool showText;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showLogo) Image.asset(
            'assets/logo.png',
            height: 32,
          ),
          if (showText) ...[
            const SizedBox(
              width: 8,
            ),
            Text(
              'Gameodoro',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ]
        ],
      ),
    );
  }
}
