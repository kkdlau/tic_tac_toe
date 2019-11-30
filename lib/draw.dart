import 'dart:math';

import 'package:flutter/material.dart';

class Draw extends StatelessWidget {
  final Color color;
  const Draw({Key key, this.color}) : super(key: key);

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
              painter: DrawPainter(color),
            ),
            angle: pi / 4,
          ),
        );
      },
    );
  }
}

class DrawPainter extends CustomPainter {
  final Color color;
  const DrawPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = color
      ..strokeWidth = size.height / 15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 3, circlePaint);
    final crossPaint = Paint()
      ..color = color
      ..strokeWidth = size.height / 15
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), crossPaint);
    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height), crossPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
