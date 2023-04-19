import 'package:gameodoro/utils.dart';

const sessionMessages = [
  "Let's get started! Focus for the next 25 minutes and make the most of your study session",
  'Great job! Take a short break to recharge and get ready for the next session.',
  "You're doing great! Take a long break to relax and recharge before the next study session.",
];

const focusSessionMessages = [
  "Welcome back! Let's continue where we left off and make the most of the remaining time in this study session.",
  "Welcome back! Let's get back into the study mode and make the most of the remaining study sessions.",
];

/// Use guideline SRS https://harddrop.com/wiki/SRS#Wall_Kicks
final List<Block> blocks = [
  Block(
    [
      [
        [1, 1, 1, 1],
      ],
      [
        [1],
        [1],
        [1],
        [1],
      ],
    ],
    0,
  ),
  Block(
    [
      [
        [1, 0, 0],
        [1, 1, 1],
      ],
      [
        [1, 1],
        [1, 0],
        [1, 0]
      ],
      [
        [1, 1, 1],
        [0, 0, 1]
      ],
      [
        [0, 1],
        [0, 1],
        [1, 1]
      ],
    ],
    1,
  ),
  Block(
    [
      [
        [0, 0, 1],
        [1, 1, 1],
      ],
      [
        [1, 0],
        [1, 0],
        [1, 1]
      ],
      [
        [1, 1, 1],
        [1, 0, 0]
      ],
      [
        [1, 1],
        [0, 1],
        [0, 1]
      ],
    ],
    2,
  ),
  Block(
    [
      [
        [1, 1],
        [1, 1],
      ]
    ],
    3,
  ),
  Block(
    [
      [
        [0, 1, 1],
        [1, 1, 0],
      ],
      [
        [1, 0],
        [1, 1],
        [0, 1]
      ],
    ],
    4,
  ),
  Block(
    [
      [
        [0, 1, 0],
        [1, 1, 1],
      ],
      [
        [1, 0],
        [1, 1],
        [1, 0]
      ],
      [
        [1, 1, 1],
        [0, 1, 0]
      ],
      [
        [0, 1],
        [1, 1],
        [0, 1]
      ],
    ],
    5,
  ),
  Block(
    [
      [
        [1, 1, 0],
        [0, 1, 1],
      ],
      [
        [0, 1],
        [1, 1],
        [1, 0]
      ],
    ],
    6,
  ),
];
