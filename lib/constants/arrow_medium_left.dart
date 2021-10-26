import 'package:flutter/material.dart';

// Shapemaker resource https://i.imgur.com/edwaZLk.png

class ArrowMediumLeft extends CustomPainter {
  ArrowMediumLeft(this.disabled);

  final bool disabled;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = disabled ? Colors.grey : Colors.yellow.shade600
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width, size.height * 0.1500000);
    path0.lineTo(size.width * 0.4000000, size.height * 0.1500000);
    path0.lineTo(size.width * 0.4000000, size.height * 0.7500000);
    path0.lineTo(size.width * 0.3000000, size.height * 0.7500000);
    path0.lineTo(size.width * 0.5000000, size.height);
    path0.lineTo(size.width * 0.7000000, size.height * 0.7500000);
    path0.lineTo(size.width * 0.6007500, size.height * 0.7500000);
    path0.lineTo(size.width * 0.6000000, size.height * 0.3503500);
    path0.lineTo(size.width, size.height * 0.3506000);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
