import 'package:flutter/material.dart';

import 'package:scapia_hand_cricket_task/constants/app_assets.dart';
import 'package:scapia_hand_cricket_task/extensions/padding_extension.dart';

class ShowCharms extends StatefulWidget {
  final String charm;
  final int? toWin;
  const ShowCharms({super.key, required this.charm, this.toWin});

  @override
  State<ShowCharms> createState() => _ShowCharmsState();
}

class _ShowCharmsState extends State<ShowCharms> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.charm).paddingSymmetric(horizontal: 24),
          Visibility(
            visible: widget.toWin != null,
            child: GradientText(
              widget.toWin.toString(),
              gradient: LinearGradient(
                colors: [Color(0xff0883FD), Color(0xff8CD1FB)],
              ),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ).paddingOnly(top: 20),
          ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(
          fontSize: 70,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ), // White ensures proper blending
      ),
    );
  }
}
