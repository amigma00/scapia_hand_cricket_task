import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart' as rive;
import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/constants/app_labels.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';
import 'package:scapia_hand_cricket_task/game/view/game.dart';

class InDialog extends StatefulWidget {
  const InDialog({super.key});

  @override
  State<InDialog> createState() => _InDialogState();
}

class _InDialogState extends State<InDialog> {
  // void setHandGesture(rive.SMIInput<double>? input, int number) {
  //   if (input != null) {
  //     input.value = number.toDouble();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      insetPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.amber, width: 1),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.red.shade900],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -50,
              child: Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..rotateY(3.1415926535), // Flip horizontally
                child: SizedBox(
                  height: 175,
                  width: 175,
                  child: rive.RiveAnimation.asset(
                    AppRives.hands,
                    animations: ['Three'],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -5,
              right: -30,
              child: SizedBox(
                height: 175,
                width: 175,

                child: rive.RiveAnimation.asset(
                  AppRives.hands,
                  animations: ['One'],
                  fit: BoxFit.contain,
                ),
              ),
            ),

            ColoredBox(
              color: Colors.black.withValues(alpha: .5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(20),
                  AppLabels.howToPlay.textGilroy900(35, color: Colors.amber),
                  Gap(30),
                  stepOne(),
                  Gap(10),
                  stepTwo(),
                  Gap(10),
                  stepThree(),
                  Gap(35),
                  button(),
                ],
              ).paddingAll(24),
            ),
          ],
        ),
      ),
    );
  }

  TextButton button() {
    return TextButton(
      onPressed: () => Navigator.pop(context, true),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.shade300,
              Colors.amber.shade700,
            ], // Gold gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        // Adjust size
        alignment: Alignment.center,
        child: AppLabels.startPlaying.textGilroy900(18, color: Colors.black),
      ),
    );
  }

  SizedBox stepTwo() {
    return SizedBox(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(children: [stepTwoA(), Gap(10), stepTwoB()]),
      ),
    );
  }

  Expanded stepTwoB() {
    return Expanded(
      flex: 45,
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                AppLabels.differentNumber.textGilroy600(14),
                AppLabels.youScoreRuns.textGilroy600(14, color: Colors.green),
              ],
            ).paddingAll(10),
            Positioned(
              top: 30,
              right: 30,
              child: Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..rotateZ(-.8) // Rotate 45 degrees
                      ..rotateY(3.1415926535), // Flip horizontally
                child: Container(
                  height: 150,
                  width: 150,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: rive.RiveAnimation.asset(
                    AppRives.hands,
                    animations: ['Three'],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -6,
              child: Transform(
                alignment: Alignment.bottomCenter,
                transform:
                    Matrix4.identity()..rotateZ(0.8), // Rotate 45 degrees
                // ..rotateY(
                //   3.1415926535,
                // ), // Flip horizontally
                child: Container(
                  height: 150,
                  width: 150,
                  // color: Colors.red,
                  child: rive.RiveAnimation.asset(
                    AppRives.hands,
                    animations: ['One'],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded stepTwoA() {
    return Expanded(
      flex: 55,
      child: ColoredBox(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepCircle('2'),
            Gap(5),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppLabels.sameNumber.textGilroy600(
                        14,
                        textAlign: TextAlign.center,
                      ),
                      AppLabels.youreOut.textGilroy600(
                        textAlign: TextAlign.center,
                        14,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 20,
                    right: 30,
                    child: Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.identity()
                            ..rotateZ(-.8) // Rotate 45 degrees
                            ..rotateY(3.1415926535), // Flip horizontally
                      child: Container(
                        height: 150,
                        width: 150,
                        // color: Colors.red,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: rive.RiveAnimation.asset(
                          AppRives.hands,
                          animations: ['Three'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: -6,
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform:
                          Matrix4.identity()..rotateZ(0.8), // Rotate 45 degrees
                      // ..rotateY(
                      //   3.1415926535,
                      // ), // Flip horizontally
                      child: SizedBox(
                        height: 150,
                        width: 150,

                        child: rive.RiveAnimation.asset(
                          AppRives.hands,
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
        ).paddingOnly(top: 10, left: 10),
      ),
    );
  }

  stepOne() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stepCircle('1'),
          Gap(15),
          Expanded(child: AppLabels.tapToScoreRuns.textGilroy700(18)),
          ClipRect(
            clipBehavior: Clip.antiAlias,
            child: OverflowBox(
              fit: OverflowBoxFit.deferToChild,
              child: Transform.translate(
                offset: Offset(25, 0), // move widget up by 20 pixels
                child: Row(
                  children: List.generate(3, (index) {
                    return stepOneButtons(index);
                  }),
                ),
              ),
            ),
          ),
        ],
      ).paddingOnly(top: 10, left: 10, bottom: 10),
    );
  }

  stepOneButtons(int index) {
    return index == 0
        ? Image.asset(AppImages.three, height: 50, width: 50)
        : ColorFiltered(
          colorFilter: ColorFilter.matrix(const [
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: Image.asset(
            [AppImages.three, AppImages.two, AppImages.one][index],
            height: 50,
            width: 50,
          ),
        );
  }

  Widget stepThree() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stepCircle('3'),
          Gap(15),
          Expanded(child: AppLabels.highestScorer.textGilroy700(18)),
          Image.asset(AppImages.logo, height: 70, width: 70),
        ],
      ).paddingAll(10),
    );
  }

  Widget stepCircle(String count) {
    return Container(
      width: 20, // Adjust size
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          stops: [0, 0.2, 1], // Gradient stops
          colors: [Colors.red, Colors.red, Colors.black87], // Dark to light red
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6), // Shadow effect
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        count,
        style: TextStyle(
          color: Colors.amber.shade300, // Gold text color
          fontWeight: FontWeight.w900,
          height: 0,
        ),
      ),
    );
  }
}
