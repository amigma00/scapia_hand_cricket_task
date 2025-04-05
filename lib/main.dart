import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';
import 'package:scapia_hand_cricket_task/start_dialog.dart';

void main() {
  runApp(MaterialApp(home: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text('Hello World!', textAlign: TextAlign.center),
          TextButton(
            onPressed: () => startGame(context),
            child: Text('strat game'),
          ),
        ],
      ),
    );
  }
}

void startGame(BuildContext context) {
  showDialog(context: context, builder: (context) => InDialog());
}
