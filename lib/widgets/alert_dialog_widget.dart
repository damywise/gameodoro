import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    required this.isDialogShowing,
    super.key,
  });

  final ValueNotifier<bool> isDialogShowing;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Break is Over'),
      content: const Text('Time to continue your study'),
      actions: [
        TextButton(
          onPressed: () {
            isDialogShowing.value = false;
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Go back'),
        ),
        FilledButton(
          onPressed: () {
            isDialogShowing.value = false;
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text("Let's go!"),
        ),
      ],
    );
  }
}
