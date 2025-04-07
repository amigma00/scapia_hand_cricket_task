import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/game/Widgets/show_charms.dart';
import 'package:scapia_hand_cricket_task/game/cubit/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameStarted> {
  GameCubit() : super(GameStarted());

  CountDownController circularController = CountDownController();

  void onButtonPressed(int number, BuildContext context) async {
    var currentScores = List<int>.from(state.scores ?? []);
    var currentBalls = List<bool>.from(state.ball ?? []);

    //Bot playing random hand gesture from 1 to 6
    final botGesture = random6();

    //Checking if user is out
    if (botGesture != number) {
      currentScores.add(number);
      currentBalls.add(true);
      if (number == 6) {
        showCharms(context, charm: AppImages.sixer);
      }
      emit(
        state.copyWith(
          handGesture: [number, botGesture],
          scores: currentScores,
          ball: currentBalls,
        ),
      );
    } else {
      circularController.pause();
      //if bot is out
      if (state.isBotBatting == true) {
        emit(state.cleared);
        await showCharms(context, charm: AppImages.youWon);
        print('you win');
        circularController.start();
        return;
      }
      //if user out then 2 inninngs starts
      else if (await showCharms(context, charm: AppImages.out) ?? false) {
        startSecondInnings(state.scores?.reduce((a, b) => a + b) ?? 0, context);
        return;
      }
    }

    //Checking if game is over
    currentBalls = List<bool>.from(state.ball ?? []);
    currentScores = List<int>.from(state.scores ?? []);

    int? score = currentScores.reduce((a, b) => a + b);
    if ((score) >= (state.toWin ?? 0) && (state.isBotBatting ?? false)) {
      circularController.pause();
      await Future.delayed(Duration(seconds: 2), () {
        showDialog(
          context: context,
          builder: (context) => Dialog(child: Text('you loose')),
        );
      });
      print('you loss');
      emit(state.cleared);
      return;
    } else if (currentBalls.length == 6) {
      circularController.pause();
      startSecondInnings(score, context);
    }
    print(currentScores);
    print(currentBalls);
  }

  startSecondInnings(int toWin, BuildContext context) async {
    await showCharms(context, charm: AppImages.defend, toWin: toWin + 1);
    emit(
      state.copyWith(
        toWin: toWin + 1,
        scores: [],
        ball: [],
        isBotBatting: true,
        isBotStart: true,
      ),
    );
    circularController.reset();
  }

  // endgame() => emit(state.copyWith(isBotBatting: false));

  Future<bool?> showCharms(BuildContext context, {String? charm, int? toWin}) =>
      showDialog<bool>(
        context: context,
        builder:
            (context) =>
                ShowCharms(charm: charm ?? AppImages.batting, toWin: toWin),
      );

  void isTogBotStart() => emit(state.copyWith(isBotStart: false));
}

int random6() {
  return Random().nextInt(6) + 1;
}
