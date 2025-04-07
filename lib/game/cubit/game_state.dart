import 'package:circular_countdown_timer/circular_countdown_timer.dart';

enum GameStatus { initial, loading, success, failure }

extension GameX on GameStatus {
  bool get isInitial => this == GameStatus.initial;
  bool get isLoading => this == GameStatus.loading;
  bool get isSuccess => this == GameStatus.success;
  bool get isFailure => this == GameStatus.failure;
}

class GameState {}

class GameStarted extends GameState {
  final int? toWin;
  final List<bool>? ball;
  final List<int>? scores;
  final List<int>? handGesture;
  final bool? isBotBatting;
  final bool? isBotStart;
  final GameStatus? status;

  GameStarted({
    this.isBotStart,
    this.ball,
    this.toWin,
    this.scores,
    this.handGesture,
    this.isBotBatting,
    this.status,
  });

  GameStarted copyWith({
    int? toWin,
    List<bool>? ball,
    List<int>? scores,
    List<int>? handGesture,
    bool? isBotBatting,
    bool? isBotStart,
    GameStatus? status,
  }) => GameStarted(
    toWin: toWin ?? this.toWin,
    ball: ball ?? this.ball,
    scores: scores ?? this.scores,
    handGesture: handGesture ?? this.handGesture,
    isBotBatting: isBotBatting ?? this.isBotBatting,
    isBotStart: isBotStart ?? this.isBotStart,
    status: status ?? this.status,
  );
  GameStarted get cleared => GameStarted(
    toWin: null,
    ball: null,
    scores: null,
    handGesture: null,
    isBotBatting: false,
    status: GameStatus.initial,
  );
}
