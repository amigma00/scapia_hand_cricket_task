import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/game/Widgets/show_charms.dart';
import 'package:scapia_hand_cricket_task/game/cubit/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameStarted> {
  GameCubit() : super(GameStarted());

  void onButtonPressed(int number, BuildContext context) {
    var currentScores = List<int>.from(state.scores ?? []);
    var currentBalls = List<bool>.from(state.ball ?? []);

    if (currentBalls.length == 6) {
      emit(state.cleared);
    }
    final botGesture = random6();

    currentScores = List<int>.from(state.scores ?? []);
    currentBalls = List<bool>.from(state.ball ?? []);

    if (botGesture != number) {
      currentScores.add(number);
      currentBalls.add(true);
      if (number == 6) {
        showCharms(context);
      }
    }

    emit(
      state.copyWith(
        handGesture: [number, botGesture],
        scores: currentScores,
        ball: currentBalls,
      ),
    );

    print(currentScores);
    print(currentBalls);
  }

  void showCharms(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => ShowCharms(charm: AppImages.batting),
  );
}

int random6() {
  return Random().nextInt(6) + 1;
}
