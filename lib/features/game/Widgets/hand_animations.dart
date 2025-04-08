import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:scapia_hand_cricket_task/constants/app_assets.dart';

class HandGestureScreen extends StatefulWidget {
  int currentGesture;
  HandGestureScreen({super.key, required this.currentGesture});

  @override
  HandGestureScreenState createState() => HandGestureScreenState();
}

class HandGestureScreenState extends State<HandGestureScreen> {
  late rive.StateMachineController? _controller;
  rive.SMIInput<double>? _gestureInput;

  void _onRiveInit(rive.Artboard artboard) {
    _controller = rive.StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    if (_controller != null) {
      artboard.addController(_controller!);
      _gestureInput = _controller?.findInput<double>('Input');
      _gestureInput?.value = widget.currentGesture.toDouble();
    }
  }

  void _changeGesture(int newGesture) {
    widget.currentGesture = newGesture;
    final val = newGesture.toDouble();
    _gestureInput?.value = val == 1 ? 0 : val - 1;
    Future.delayed(Duration(milliseconds: 5), () {
      _gestureInput?.value = val;
    });
  }

  @override
  void didUpdateWidget(covariant HandGestureScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _changeGesture(widget.currentGesture);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: rive.RiveAnimation.asset(
        AppRives.hands,
        stateMachines: ['State Machine 1'],
        onInit: _onRiveInit,
      ),
    );
  }
}
