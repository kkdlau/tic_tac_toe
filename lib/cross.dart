import 'dart:math';

import 'package:flutter/material.dart';

class Cross extends StatelessWidget {
  final Color color;
  const Cross({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double size = constraints.maxWidth > constraints.maxHeight? constraints.maxHeight: constraints.maxWidth;
        return Transform.scale(
          scale: 1 / sqrt2,
          child: Transform.rotate(
            child: CustomPaint(
              size: Size(size, size),
              painter: CrossPainter(color),
            ),
            angle: pi / 4,
          ),
        );
      },
    );
  }
}

class CrossPainter extends CustomPainter {
  final Color color;
  const CrossPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height / 10
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
