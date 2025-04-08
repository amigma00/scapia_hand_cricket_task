import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:scapia_hand_cricket_task/components/scapia_button.dart';
import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';
import 'package:scapia_hand_cricket_task/features/game/Widgets/show_charms.dart';
import 'package:scapia_hand_cricket_task/features/game/Widgets/you_loose_dialog.dart';
import 'package:scapia_hand_cricket_task/features/game/cubit/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia_hand_cricket_task/main.dart';

class GameCubit extends Cubit<GameStarted> {
  GameCubit() : super(GameStarted());

  CountDownController circularController = CountDownController();

  // void onButtonPressed(int number, BuildContext context) async {
  //   var currentScores = List<int>.from(state.scores ?? []);
  //   var currentBalls = List<bool>.from(state.ball ?? []);

  //   //Bot playing random hand gesture from 1 to 6
  //   final botGesture = random6();

  //   //Checking if user is out
  //   if (botGesture != number) {
  //     currentScores.add(number);
  //     currentBalls.add(true);
  //     if (number == 6) {
  //       showCharms(context, charm: AppImages.sixer);
  //     }
  //     emit(
  //       state.copyWith(
  //         handGesture: [number, botGesture],
  //         scores: currentScores,
  //         ball: currentBalls,
  //       ),
  //     );
  //   } else {
  //     circularController.pause();
  //     emit(state);
  //     //if bot is out
  //     if (state.isBotBatting == true) {
  //       emit(state.cleared);
  //       await showCharms(context, charm: AppImages.youWon);
  //       print('you win');
  //       return;
  //     }
  //     //if user out then 2 inninngs starts
  //     else if (await showCharms(context, charm: AppImages.out) ?? false) {
  //       startSecondInnings(state.scores?.reduce((a, b) => a + b) ?? 0, context);
  //       return;
  //     }
  //   }

  //   //Checking if game is over
  //   currentBalls = List<bool>.from(state.ball ?? []);
  //   currentScores = List<int>.from(state.scores ?? []);

  //   int? score = currentScores.reduce((a, b) => a + b);
  //   if ((score) >= (state.toWin ?? 0) && (state.isBotBatting ?? false)) {
  //     circularController.pause();
  //     emit(state);
  //     bool isPlayAgain = await Future<bool>.delayed(
  //       Duration(seconds: 1),
  //       () async {
  //         return await showDialog<bool?>(
  //           context: context,
  //           builder: (context) => YouLoose(),
  //         ).then((value) => value ?? true);
  //       },
  //     );
  //     circularController.reset();
  //     if (isPlayAgain) {
  //       Navigator.pop(context);
  //       emit(state.cleared);
  //     }

  //     return;
  //   } else if (currentBalls.length == 6 && state.isBotBatting == true) {
  //     await showCharms(context, charm: AppImages.youWon);
  //     circularController.start();
  //     emit(state.cleared);
  //     return;
  //   } else if (currentBalls.length == 6) {
  //     circularController.pause();
  //     emit(state);
  //     startSecondInnings(score, context);
  //   }
  // }

  void onButtonPressed(int number) async {
    final rootContext = MyApp.navigatorKey.currentContext;
    if (rootContext == null) return; // Safety check
    var currentScores = List<int>.from(state.scores ?? []);
    var currentBalls = List<bool>.from(state.ball ?? []);
    final botGesture = random6();
    final isOut = botGesture == number;

    // Emit initial state update (safe since no context used yet)
    emit(state.copyWith(handGesture: [number, botGesture]));

    if (isOut) {
      circularController.pause();
      emit(state);
      if (!rootContext.mounted) return;

      if (state.isBotBatting == true) {
        emit(state.cleared);
        await showCharms(rootContext, charm: AppImages.youWon);
      } else {
        final shouldStartSecond = await showCharms(
          rootContext,
          charm: AppImages.out,
        );
        if (shouldStartSecond == true && rootContext.mounted) {
          final total = (state.scores ?? []).fold(0, (a, b) => a + b);
          startSecondInnings(
            total,
          ); // Ensure this method checks mounted internally
        }
      }
      return;
    }

    // Update scores and balls
    currentScores.add(state.isBotBatting == true ? botGesture : number);
    currentBalls.add(true);

    // Show sixer animation if applicable
    if (rootContext.mounted &&
        (state.isBotBatting == true ? botGesture == 6 : number == 6)) {
      await showCharms(rootContext, charm: AppImages.sixer);
    }

    // Emit updated state
    emit(state.copyWith(scores: currentScores, ball: currentBalls));

    final score = currentScores.fold(0, (a, b) => a + b);
    final toWin = state.toWin ?? 0;

    if (!rootContext.mounted) return;

    // Bot batting and exceeds target score
    if (state.isBotBatting == true && score >= toWin) {
      circularController.pause();
      emit(state);
      await Future.delayed(Duration(seconds: 1));

      emit(state.cleared);

      if (rootContext.mounted) {
        await showDialog<bool>(
          context: rootContext,
          builder: (_) => YouLoose(),
        ).then((value) {
          circularController.reset();
        });
      }
      circularController.reset();

      return;
    }

    // End of over (6 balls)
    if (currentBalls.length == 6) {
      circularController.pause();
      emit(state);
      if (!rootContext.mounted) return;

      if (state.isBotBatting == true) {
        await showCharms(rootContext, charm: AppImages.youWon);
        circularController.start();
        emit(state.cleared);
      } else {
        startSecondInnings(
          score,
        ); // Ensure this method checks mounted internally
      }
    }
  }

  startSecondInnings(int toWin) async {
    final rootContext = MyApp.navigatorKey.currentContext;
    if (rootContext == null) return; // Safety check
    await showCharms(rootContext, charm: AppImages.defend, toWin: toWin + 1);
    emit(
      state.copyWith(
        toWin: toWin + 1,
        scores: [],
        ball: [],
        isBotBatting: true,
        isBotStart: true,
        isSecondInningStart: true,
      ),
    );
    circularController.reset();
    emit(state);
  }

  Future<bool?> showCharms(BuildContext context, {String? charm, int? toWin}) =>
      showDialog<bool>(
        context: context,
        builder:
            (context) =>
                ShowCharms(charm: charm ?? AppImages.batting, toWin: toWin),
      );

  void isTogBotStart() =>
      emit(state.copyWith(isBotStart: false, isSecondInningStart: false));
}

int random6() {
  return Random().nextInt(6) + 1;
}
