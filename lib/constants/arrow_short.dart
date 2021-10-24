import 'package:flutter/material.dart';

// Shapemaker resource https://i.imgur.com/hT9q9RR.png

class ArrowShort extends CustomPainter {
  final bool disabled;

  ArrowShort(this.disabled);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = disabled ? Colors.grey : Colors.yellow.shade600
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.3000000, size.height * 0.2500000);
    path0.lineTo(size.width * 0.7000000, size.height * 0.2500000);
    path0.lineTo(size.width * 0.7000000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.9000000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.5000000, size.height * 0.7500000);
    path0.lineTo(size.width * 0.1000000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.3000000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.3000000, size.height * 0.2500000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
