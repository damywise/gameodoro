import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameodoro/main.dart';
import 'package:gameodoro/pages/games/snake_page.dart';
import 'package:gameodoro/pages/games/tetris_page.dart';
import 'package:gameodoro/pages/games_page.dart';
import 'package:gameodoro/pages/home_page.dart';
import 'package:gameodoro/pages/onboarding_page.dart';
import 'package:gameodoro/pages/to_do_list_page.dart';
import 'package:gameodoro/utils.dart';
import 'package:gameodoro/widgets/alert_dialog_widget.dart';
import 'package:gameodoro/widgets/notification_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  group('Testing full app flow', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Test Onboarding and Tutorial', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final pref = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferences.overrideWithValue(pref)],
          child: const Main(),
        ),
      );
      await tester.pumpAndSettle();

      // make sure we are on the onboarding page
      expect(find.byType(OnboardingPage), findsOneWidget);

      // make sure we are on the first slide by finding text
      expect(find.text(OnboardingPage.descriptions[0]), findsOneWidget);

      // make sure button says 'Next'
      expect(find.text('Next'), findsOneWidget);

      // go to next slide by tapping button
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      // make sure we are on the second slide by finding text
      expect(find.text(OnboardingPage.descriptions[1]), findsOneWidget);

      // go to next slide by swiping left on pageview
      await tester.drag(find.byType(PageView), const Offset(-1000, 0));
      await tester.pumpAndSettle();

      // make sure we are on the third slide by finding text
      expect(find.text(OnboardingPage.descriptions[2]), findsOneWidget);

      // make sure the button says 'Take me to Gameodoro!' and tap the button
      expect(find.text('Take me to Gameodoro!'), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      tester.binding.scheduleFrame();
      await tester.pumpAndSettle();

      // make sure we are in home page
      expect(find.byType(HomePage), findsOneWidget);

      // make sure ShowCaseWidget is there
      expect(find.byType(ShowCaseWidget), findsOneWidget);

      // start tutorial
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 500));

      final texts = [
        'This is the pomodoro timer.\nYou can tap on the timer to modify focus, short break, and long break session durations\n\nTap anywhere to continue',
        'This text shows the current session mode.\nThere 3 modes: "Focus", "Short Break, and "Long Break".',
        'Tap this button to start the pomodoro session',
        'Go back to previous session',
        'Skip to the next session',
        'Reset the timer for current session',
        "Change the notification sound.\nIt's silent by default",
        'This is a todo list preview.\nYou can use the "Todo List" button below to further manage your tasks.',
        'Todo List, manage your tasks here',
        'Fullscreen focus mode',
        'You can play games during break session.\nGames will be locked when focus session starts.',
        'All settings are over here',
        'You can repeat this tutorial anytime you want',
      ];

      for (final text in texts) {
        // find text
        expect(
          find.text(text),
          findsOneWidget,
        );

        // tap anywhere to continue
        await tester.tapAt(Offset.zero);
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 500));
      }

      // TODO(damywise): open and skip tutorial

      // make sure tutorial is finished
      await tester.pumpAndSettle();
      expect(find.text(texts.last), findsNothing);
    });

    testWidgets('Test Timers', (tester) async {
      SharedPreferences.setMockInitialValues({
        'firstopen': false,
      });
      final pref = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferences.overrideWithValue(pref)],
          child: const Main(),
        ),
      );
      await tester.pumpAndSettle();

      // make sure we are in home page
      expect(find.byType(HomePage), findsOneWidget);

      // tap on notification sound button
      await tester.tap(find.byTooltip('Notification Sound'));
      await tester.pumpAndSettle();
      // make sure notification sound dialog is shown
      expect(find.byType(TuneWidget), findsOneWidget);

      // top on 'Positive Notification'
      await tester.tap(find.text('Positive Notification'));
      await tester.pumpAndSettle();
      // TODO(damywise): Make sure the tile is selected

      // close the notification sound dialog
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      // make sure notification sound dialog is not shown
      expect(find.byType(TuneWidget), findsNothing);

      // tap on the 'Focus' text to show timer dialog
      await tester.tap(find.text('Focus'));
      await tester.pumpAndSettle();
      // make sure timer dialog is shown
      expect(find.byType(TimerPickerDialog), findsOneWidget);

      // TODO(damywise): make sure in focus
      await tester.drag(
        find.text('min.'),
        const Offset(0, 200 * 25 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Short Break'));
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('min.'),
        const Offset(0, 200 * 5 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Long Break'));
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('min.'),
        const Offset(0, 200 * 15 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      // no need, since the default is 1 seconds anyway
      // await tester.fling(find.text('sec.'), const Offset(0, -200 * 1 / 6), 100);
      // await tester.pumpAndSettle();

      // close the timer dialog
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      // make sure timer dialog is not shown
      expect(find.byType(TimerPickerDialog), findsNothing);

      // tap on the 'Start' button
      await tester.tap(find.text('Start'));
      await tester.pump();

      // wait for 1 seconds
      await tester.pump(const Duration(seconds: 1));
      // expect NotificationWidget
      expect(find.byType(NotificationWidget), findsOneWidget);
      expect(find.text('Short Break'), findsOneWidget);
      // tap on the 'Pause' button
      await tester.tap(find.text('Pause'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(NotificationWidget), const Offset(1000, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Reset Timer'));
      await tester.pumpAndSettle();

      // disable notification
      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Notification'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      // tap on the 'Start' button
      await tester.tap(find.text('Start'));
      await tester.pump();

      // wait for 1 seconds
      await tester.pump(const Duration(seconds: 1));
      // expect no NotificationWidget
      expect(find.byType(NotificationWidget), findsNothing);
      expect(find.text('Focus'), findsOneWidget);
      // tap on the 'Pause' button
      await tester.tap(find.text('Pause'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Reset Timer'));
      await tester.pumpAndSettle();

      // enable notification
      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Notification'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Previous Session'));
      await tester.pumpAndSettle();
      // tap on the 'Start' button
      await tester.tap(find.text('Start'));
      await tester.pump();

      // wait for 1 seconds
      await tester.pump(const Duration(seconds: 1));
      // expect NotificationWidget
      expect(find.byType(NotificationWidget), findsOneWidget);
      expect(find.text('Focus'), findsOneWidget);
      // tap on the 'Pause' button
      await tester.tap(find.text('Pause'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Reset Timer'));
      await tester.pumpAndSettle();

      // go to fullscreen mode
      await tester.tap(find.text('Fullscreen'));
      await tester.pumpAndSettle();

      // tap on the play button
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump();

      // wait for 1 seconds
      await tester.pump(const Duration(seconds: 1));
      // expect NotificationWidget
      expect(find.byType(NotificationWidget), findsOneWidget);
      expect(find.text('Long Break'), findsOneWidget);
      // tap on the pause button
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(NotificationWidget), const Offset(1000, 0));
      await tester.pumpAndSettle();

      // go back to home page
      await tester.tap(find.byIcon(Icons.close_fullscreen));
      await tester.pumpAndSettle();
      // TODO(damywise): test the skip and previous button

      // make sure we are in home page
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('Test Todolist', (tester) async {
      SharedPreferences.setMockInitialValues({
        'firstopen': false,
      });
      final pref = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferences.overrideWithValue(pref)],
          child: const Main(),
        ),
      );
      await tester.pumpAndSettle();

      // make sure we are in home page
      expect(find.byType(HomePage), findsOneWidget);
      // go to todolist page
      await tester.tap(find.byIcon(Icons.edit_note));
      await tester.pumpAndSettle();

      // make sure we are on todolist page
      expect(find.byType(ToDoListPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsOneWidget);
      await tester.tap(find.byType(TextFormField));
      await tester.enterText(find.byType(TextFormField), 'Testing Gameodoro!');
      await tester.pumpAndSettle();
      expect(find.text('Testing Gameodoro!'), findsOneWidget);

      // check in home page
      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text('Testing Gameodoro!'), findsOneWidget);

      // go to todolist page
      await tester.tap(find.byIcon(Icons.edit_note));
      tester.binding.scheduleFrame();
      await tester.pumpAndSettle();

      // make the task completed
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      // go to finished tab
      await tester.tap(find.text('Finished'));
      await tester.pumpAndSettle();
      // make sure the task is in there
      expect(find.text('Testing Gameodoro!'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      // make sure we are in home page
      expect(find.byType(HomePage), findsOneWidget);
      // make sure no task is in home page
      expect(find.byType(TextFormField), findsNothing);
    });

    testWidgets('Test Game Pause', (tester) async {
      SharedPreferences.setMockInitialValues({
        'firstopen': false,
      });
      final pref = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferences.overrideWithValue(pref)],
          child: const Main(),
        ),
      );
      await tester.pumpAndSettle();

      // make sure we are in home page
      expect(find.byType(HomePage), findsOneWidget);

      // tap on the 'Focus' text to show timer dialog
      await tester.tap(find.text('Focus'));
      await tester.pumpAndSettle();
      // make sure timer dialog is shown
      expect(find.byType(TimerPickerDialog), findsOneWidget);

      // set all timers to 2 seconds
      await tester.drag(
        find.text('min.'),
        const Offset(0, 200 * 25 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('sec.'),
        const Offset(0, -200 * 2.5 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Short Break'));
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('min.'),
        const Offset(0, 200 * 5 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('sec.'),
        const Offset(0, -200 * 2.5 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Long Break'));
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('min.'),
        const Offset(0, 200 * 15 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.text('sec.'),
        const Offset(0, -200 * 2.5 / 6),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      // close the timer dialog
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      // make sure timer dialog is not shown
      expect(find.byType(TimerPickerDialog), findsNothing);

      // start from short break
      await tester.tap(find.byTooltip('Next Session'));
      await tester.pumpAndSettle();
      // tap on the 'Start' button
      await tester.tap(find.text('Start'));
      await tester.pump();

      // go to games page
      await tester.tap(find.byIcon(Icons.videogame_asset));
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(find.byType(GamesPage), findsOneWidget);
      // go to tetris page
      await tester.tap(find.byKey(const ValueKey('play_Tetris')));
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(find.byType(TetrisPage), findsOneWidget);
      // expect no AlertDialogWidget
      expect(find.byType(AlertDialogWidget), findsNothing);

      // wait 2 seconds
      await tester.pump(const Duration(seconds: 2));
      // expect notification widget
      expect(find.byType(NotificationWidget), findsOneWidget);

      // expect AlertDialogWidget
      expect(find.byType(AlertDialogWidget), findsOneWidget);
      // press go back
      await tester.tap(find.text('Go back'));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      await tester.drag(find.byType(NotificationWidget), const Offset(1000, 0));
      await tester.pump();
      await tester.pump();
      await tester.pump();
      // go to snake game
      await tester.tap(find.byKey(const ValueKey('play_Snake')));
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(find.byType(SnakePage), findsOneWidget);
      // expect AlertDialogWidget immediately
      expect(find.byType(AlertDialogWidget), findsOneWidget);
      // press let's go
      await tester.tap(find.text("Let's go!"));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      // make sure we're in home page
      expect(find.byType(HomePage), findsOneWidget);

    });
  });

}
