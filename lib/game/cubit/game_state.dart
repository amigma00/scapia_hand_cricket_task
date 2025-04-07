enum GameStatus { initial, loading, success, failure }

extension GameX on GameStatus {
  bool get isInitial => this == GameStatus.initial;
  bool get isLoading => this == GameStatus.loading;
  bool get isSuccess => this == GameStatus.success;
  bool get isFailure => this == GameStatus.failure;
}

class GameState {}

class GameStarted extends GameState {
  final List<bool>? ball;
  final List<int>? scores;
  final List<int>? handGesture;
  final bool? isBotBatting;
  final GameStatus? status;

  GameStarted({
    this.ball,
    this.scores,
    this.handGesture,
    this.isBotBatting,
    this.status,
  });

  GameStarted copyWith({
    List<bool>? ball,
    List<int>? scores,
    List<int>? handGesture,
    bool? isBotBatting,
    GameStatus? status,
  }) => GameStarted(
    ball: ball ?? this.ball,
    scores: scores ?? this.scores,
    handGesture: handGesture ?? this.handGesture,
    isBotBatting: isBotBatting ?? this.isBotBatting,
    status: status ?? this.status,
  );
  GameStarted get cleared => GameStarted(
    ball: null,
    scores: null,
    handGesture: null,
    isBotBatting: false,
    status: GameStatus.initial,
  );
}
