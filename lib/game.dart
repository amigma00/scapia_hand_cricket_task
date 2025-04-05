import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(100),
          SizedBox(
            height: 75,

            child: CustomPaint(
              painter: ParallelogramPainter(),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class ParallelogramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //BORDERS
    final paintBorder1 =
        Paint()
          ..color = Colors.amber
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;
    final pathBorder1 = Path();
    pathBorder1.moveTo((size.width / 4 + size.width / 6), 0);
    pathBorder1.lineTo((size.width / 2) - 2, size.height); // Top-right

    canvas.drawPath(pathBorder1, paintBorder1);
    final paintBorder2 =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;
    final pathBorder2 = Path();
    pathBorder2.moveTo((size.width / 2 + size.width / 12), 0);
    pathBorder2.lineTo(size.width / 2 + 2, size.height); // Top-right

    canvas.drawPath(pathBorder1, paintBorder1);
    canvas.drawPath(pathBorder2, paintBorder2);

    //SHAPERS

    final paint1 =
        Paint()
          ..shader = const LinearGradient(
            colors: [Colors.amber, Colors.amber],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(
            Rect.fromCenter(
              center: Offset(0, 0),
              width: size.width / 1,
              height: size.height,
            ),
          )
          ..style = PaintingStyle.fill;

    final paint2 =
        Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.fill;
    final paint4 =
        Paint()
          ..shader = const LinearGradient(
            colors: [Colors.red, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(
            Rect.fromCenter(
              center: Offset(size.width, 0),
              width: size.width - (size.width / 6),
              height: size.height,
            ),
          )
          ..style = PaintingStyle.fill;

    // Define parallelogram points
    final path1 = Path();

    path1.moveTo(0, 0); // Top-left
    path1.lineTo(size.width / 6, 0); // Top-right
    path1.lineTo(size.width / 12, size.height); // Bottom-right
    path1.lineTo(0, size.height); // Bottom-left
    path1.close();

    final path2 = Path();

    path2.moveTo(size.width / 6, 0); // Top-left
    path2.lineTo((size.width / 4 + size.width / 6), 0); // Top-right
    path2.lineTo(size.width / 2, size.height); // Bottom-right
    path2.lineTo(size.width / 12, size.height); // Bottom-left
    path2.close();
    final path3 = Path();

    path3.moveTo((size.width / 2 + size.width / 12), 0); // Top-left
    path3.lineTo(size.width - (size.width / 6), 0); // Top-right
    path3.lineTo(size.width - (size.width / 12), size.height); // Bottom-right
    path3.lineTo(size.width / 2, size.height); // Bottom-left
    path3.close();

    final path4 = Path();

    path4.moveTo(size.width, 0); // Top-Right
    path4.lineTo(size.width, size.height); // bottom right
    path4.lineTo(size.width - (size.width / 12), size.height); // bottom left
    path4.lineTo(size.width - (size.width / 6), 0); // Top Left
    path4.close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path3, paint2);
    canvas.drawPath(path4, paint4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
