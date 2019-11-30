import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final Color color;
  const Circle({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double size = constraints.maxWidth > constraints.maxHeight? constraints.maxHeight: constraints.maxWidth;
        return CustomPaint(
              size: Size(size, size),
              painter: CirclePainter(color),
            );
      }
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  const CirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height / 15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
