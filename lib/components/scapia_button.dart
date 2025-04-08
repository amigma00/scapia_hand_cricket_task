import 'package:flutter/material.dart';
import 'package:scapia_hand_cricket_task/extensions/text_extension.dart';

class ScapiaButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const ScapiaButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(

      onPressed: onPressed,
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

        child: label.textGilroy900(18, color: Colors.black),
      ),
    );
  }
}
