import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';

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

class InDialog extends StatefulWidget {
  const InDialog({super.key});

  @override
  State<InDialog> createState() => _InDialogState();
}

class _InDialogState extends State<InDialog> {
  late StateMachineController? _userController;
  late StateMachineController? _botController;
  SMIInput<double>? _userGestureInput;
  SMIInput<double>? _botGestureInput;

  void setHandGesture(SMIInput<double>? input, int number) {
    if (input != null) {
      input.value = number.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(20),
          Text('How to play'),
          Gap(30),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text('1'),
                    ),
                    Gap(5),
                    'Tap the buttons to score Runs'.textGilroy400(12),
                  ],
                ).paddingAll(20),
              ],
            ),
          ),
          Gap(10),
          SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  Expanded(
                    child: ColoredBox(
                      color: Colors.black,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text('2'),
                          ),
                          Gap(5),
                          Expanded(
                            child: Column(
                              children: [
                                'Same number:'.textGilroy400(12),
                                "You're out!".textGilroy400(
                                  12,
                                  color: Colors.red,
                                ),
                                Gap(5),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Transform(
                                          alignment: Alignment.topLeft,
                                          transform:
                                              Matrix4.identity()
                                                ..rotateZ(
                                                  43,
                                                ) // Rotate 45 degrees
                                                ..rotateY(
                                                  3.1415926535,
                                                ), // Flip horizontally
                                          child: Container(
                                            height: 75,
                                            width: 75,
                                            // color: Colors.red,
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: RiveAnimation.asset(
                                              'assets/hand_cricket.riv',
                                              animations: ['Three'],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Transform(
                                          alignment: Alignment.topLeft,
                                          transform:
                                              Matrix4.identity()..rotateZ(
                                                1,
                                              ), // Rotate 45 degrees
                                          // ..rotateY(
                                          //   3.1415926535,
                                          // ), // Flip horizontally
                                          child: Container(
                                            height: 75,
                                            width: 75,
                                            // color: Colors.red,
                                            child: RiveAnimation.asset(
                                              'assets/hand_cricket.riv',
                                              animations: ['Three'],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: ColoredBox(
                      color: Colors.black,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text('2'),
                          ),
                          Gap(5),
                          Column(
                            children: [
                              'Same number:'.textGilroy400(12),
                              "You're out!".textGilroy400(
                                12,
                                color: Colors.red,
                              ),
                              Gap(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // User Hand Gesture
                                  Container(
                                    color: Colors.red,
                                    width: 50,
                                    height: 50,
                                    child: RiveAnimation.asset(
                                      'assets/hand_cricket.riv',
                                      animations: ['Three'],
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),

                                  Gap(5),
                                  Container(
                                    color: Colors.red,
                                    width: 50,
                                    height: 50,
                                    child: RiveAnimation.asset(
                                      'assets/hand_cricket.riv',
                                      stateMachines: ['HandStateMachine'],
                                      onInit: (artboard) {
                                        _botController =
                                            StateMachineController.fromArtboard(
                                              artboard,
                                              'HandStateMachine',
                                            );
                                        if (_botController != null) {
                                          artboard.addController(
                                            _botController!,
                                          );
                                          _botGestureInput = _botController!
                                              .findInput<double>('handGesture');
                                          setHandGesture(
                                            _botGestureInput,
                                            3,
                                          ); // Example: Bot shows 3 fingers
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).paddingAll(24),
    );
  }
}
