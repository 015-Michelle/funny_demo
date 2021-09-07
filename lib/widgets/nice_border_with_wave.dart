import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BorderWithWave extends StatefulWidget {
  const BorderWithWave({Key? key}) : super(key: key);

  @override
  _BorderWithWaveState createState() => _BorderWithWaveState();
}

class _BorderWithWaveState extends State<BorderWithWave> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: CustomPaint(
    //     size: MediaQuery.of(context).size,
    //     painter: DrawBorder(),
    //   ),
    // );
    return Scaffold(
      body: Center(
        child: DottedBorder(
          child: Container(
            height: MediaQuery.of(context).size.height - 60,
            width: MediaQuery.of(context).size.width - 30,
          ),
          dashPattern: [8, 4],
          strokeWidth: 2,
          customPath: (size) => borderPath(size),
        ),
      ),
    );
  }
}

class DrawBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint dottedPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.blue;
    Path path = borderPath(size);
    canvas.drawPath(path, dottedPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Path borderPath(Size size) {
  Path path = Path();
  path.moveTo(20, 20);
  path.lineTo(20, 20);
  path.lineTo(20, size.height - 20);
  path.lineTo(size.width - 40, size.height - 20);
  path.lineTo(size.width - 40, 20);
  path.lineTo(20, 20);
  return path;
}
