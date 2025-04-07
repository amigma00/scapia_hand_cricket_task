import 'package:flutter/material.dart';

import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';

class ShowCharms extends StatefulWidget {
  final String charm;
  const ShowCharms({super.key, required this.charm});

  @override
  State<ShowCharms> createState() => _ShowCharmsState();
}

class _ShowCharmsState extends State<ShowCharms> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () => Navigator.pop(context, true));
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: .6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(widget.charm).paddingSymmetric(horizontal: 24)],
      ),
    );
  }
}
