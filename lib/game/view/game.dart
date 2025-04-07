// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:scapia_hand_cricket_task/game/Widgets/hand_animations.dart';
import 'package:scapia_hand_cricket_task/game/Widgets/scaled_button.dart';
import 'package:scapia_hand_cricket_task/game/Widgets/score_board.dart';

import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';
import 'package:scapia_hand_cricket_task/game/Widgets/show_charms.dart';
import 'package:scapia_hand_cricket_task/game/cubit/game_cubit.dart';
import 'package:scapia_hand_cricket_task/game/cubit/game_state.dart';
import 'package:scapia_hand_cricket_task/game/Widgets/start_dialog.dart';

class Game extends StatefulWidget {
  const Game({super.key});
  static const buttons = [
    AppImages.one,
    AppImages.two,
    AppImages.three,
    AppImages.four,
    AppImages.five,
    AppImages.six,
  ];

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  CountDownController circularController = CountDownController();
  bool isStart = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await startGame(context) ?? false;
      isStart = await showCharms(context) ?? true;
      if (isStart) circularController.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: 75,
              child: CustomPaint(
                painter: ParallelogramPainter(),
                child: Container(
                  alignment: Alignment.center,

                  child: BlocBuilder<GameCubit, GameStarted>(
                    builder: (context, state) {
                      print('print scores ${state.scores}');
                      return Stack(
                        children: [
                          scoresWidget(context, state.scores ?? []).paddingOnly(
                            right: MediaQuery.of(context).size.width * .42,
                          ),
                          ballsWidget(context, state.ball ?? []).paddingOnly(
                            left: MediaQuery.of(context).size.width * .42,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: CustomPaint(
                        painter: ScoreClip(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFF5DEB3),
                              Color(0xFFD4AF37),
                            ], // Light gold to rich gold
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: ColoredBox(
                          color: Colors.red.withValues(alpha: 0.0),
                          child: Center(
                            child: ('To Win: 10').textGilroy600(
                              12,
                              color: Colors.black,
                            ),
                          ),
                        ).paddingOnly(right: 10),
                      ),
                    ),
                    Gap(20),
                    BlocBuilder<GameCubit, GameStarted>(
                      // BlocSelector<GameCubit, GameStarted, List<int>>(
                      //   selector: (state) => state.handGesture ?? [0, 0],
                      builder: (context, state) {
                        var handGesture = state.handGesture ?? [0, 0];
                        return Container(
                          width: 302,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withValues(alpha: .4),
                                BlendMode.darken,
                              ),
                              image: AssetImage(AppImages.background),
                              fit: BoxFit.cover,
                            ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform(
                                alignment: Alignment.center,
                                transform:
                                    Matrix4.identity()..rotateY(
                                      3.1415926535,
                                    ), // Flip horizontally
                                child: HandGestureScreen(
                                  currentGesture: handGesture[0],
                                  // currentGesture: 1,
                                ),
                              ),
                              HandGestureScreen(
                                currentGesture: handGesture[1],
                                // currentGesture: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Spacer(),
                    CircularCountDownTimer(
                      autoStart: false,
                      // onStart: () {},
                      onComplete: () {
                        context.read<GameCubit>().onButtonPressed(
                          random6(),
                          context,
                        );
                        Future.delayed(
                          Duration(seconds: 1),
                          () => circularController.restart(),
                        );
                      },

                      strokeCap: StrokeCap.round,
                      strokeWidth: 4,
                      fillColor: Colors.red.shade900,
                      duration: 10,
                      isReverse: true,
                      isReverseAnimation: true,
                      backgroundColor: Colors.black12.withValues(alpha: .2),
                      initialDuration: 0,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                      controller: circularController,
                      width: 50,
                      height: 50,
                      ringColor: Colors.black,
                    ),
                    Gap(10),

                    'Pick a number before timer runs out'.textGilroy700(
                      14,
                      color: Colors.white,
                    ),
                    Row(
                      children: List.generate(
                        3,
                        (index) => Expanded(
                          child: ScaledButton(
                            onTap: () {
                              circularController.restart();

                              context.read<GameCubit>().onButtonPressed(
                                index + 1,
                                context,
                              );
                            },
                            child: Image.asset(Game.buttons[index]),
                          ).paddingSymmetric(horizontal: 15),
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    Row(
                      children: List.generate(
                        3,
                        (index) => Expanded(
                          child: ScaledButton(
                            onTap: () {
                              circularController.restart();
                              context.read<GameCubit>().onButtonPressed(
                                index + 4,
                                context,
                              );
                            },
                            child: Image.asset(Game.buttons[index + 3]),
                          ).paddingSymmetric(horizontal: 15),
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container ballsWidget(BuildContext context, List<bool> tempBall) {
    var bl = tempBall + List.filled(6 - tempBall.length, false);
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      // color: Colors.red,
      width: MediaQuery.of(context).size.width * .25,
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        children: List.generate(
          bl.length,
          (index) => Container(
            foregroundDecoration: BoxDecoration(
              color: Colors.black.withValues(alpha: bl[index] ? 0 : 0.55),
              shape: BoxShape.circle,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            width: 24,
            height: 24,
            child: Image.asset(AppImages.ball),
          ),
        ),
      ),
    );
  }

  Container scoresWidget(BuildContext context, List<int> tempScores) {
    var sc = tempScores + List.filled(6 - tempScores.length, 0);
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width * .25,
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        children: List.generate(
          sc.length,
          (index) => Container(
            alignment: Alignment.center,
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: sc[index] == 0 ? Colors.black : Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: '${sc[index]}'.textGilroy500(
              color: Colors.black,
              15,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  Future startGame(BuildContext context) =>
      showDialog(context: context, builder: (context) => InDialog());

  Future<bool?> showCharms(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => ShowCharms(charm: AppImages.batting),
  );
}

class ScoreClip extends CustomPainter {
  final Gradient gradient;

  ScoreClip({required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final slant = 10.0;

    // Create the parallelogram path
    final path =
        Path()
          ..moveTo(-slant, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width - slant, size.height)
          ..lineTo(0, size.height)
          ..close();

    // Create a rounded clip path using addPath and clipping mask
    final paint =
        Paint()
          ..shader = gradient.createShader(
            Rect.fromLTWH(0, -slant, size.width, size.height),
          )
          ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
