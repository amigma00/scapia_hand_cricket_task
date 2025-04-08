import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';
import 'package:scapia_hand_cricket_task/features/game/cubit/game_cubit.dart';
import 'package:scapia_hand_cricket_task/features/game/view/game.dart';
import 'package:scapia_hand_cricket_task/features/game/Widgets/start_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: BlocProvider(create: (context) => GameCubit(), child: const Game()),
    );
  }
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Text('Hello World!', textAlign: TextAlign.center),
//           TextButton(
//             onPressed:
//                 () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Game()),
//                 ),
//             child: Text('strat game'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void startGame(BuildContext context) {
//   showDialog(context: context, builder: (context) => InDialog());
// }
