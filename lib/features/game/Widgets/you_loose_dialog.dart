import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:scapia_hand_cricket_task/components/scapia_button.dart';
import 'package:scapia_hand_cricket_task/constants/app_labels.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';

class YouLoose extends StatefulWidget {
  const YouLoose({super.key});

  @override
  State<YouLoose> createState() => _YouLooseState();
}

class _YouLooseState extends State<YouLoose> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: .6),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLabels.youAlmost.textGilroy400(
              50,
              textAlign: TextAlign.center,
              color: Colors.red,
            ),
            Gap(20),
            ScapiaButton(
              onPressed: () => Navigator.pop(context, true),
              label: AppLabels.playAgain,
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }
}
