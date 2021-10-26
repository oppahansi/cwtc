import 'package:flutter/material.dart';

// Shapemaker resource https://i.imgur.com/vEAbK3b.png

class ArrowMedium extends CustomPainter {
  ArrowMedium(this.disabled);

  final bool disabled;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = disabled ? Colors.grey : Colors.yellow.shade600
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.2962000, 0);
    path0.lineTo(size.width * 0.7019000, 0);
    path0.lineTo(size.width * 0.7000000, size.height * 0.7507000);
    path0.lineTo(size.width * 0.9000000, size.height * 0.7498000);
    path0.lineTo(size.width * 0.4962000, size.height);
    path0.lineTo(size.width * 0.1000000, size.height * 0.7508000);
    path0.lineTo(size.width * 0.3019000, size.height * 0.7507500);
    path0.lineTo(size.width * 0.2962000, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
