import 'package:flutter/material.dart';

class ArrowShortRight extends CustomPainter {
  final bool disabled;

  ArrowShortRight(this.disabled);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = disabled ? Colors.grey : Colors.yellow.shade600
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..shader;

    Path path0 = Path();
    path0.moveTo(size.width * 0.9939333, size.height * 0.4985000);
    path0.lineTo(size.width * 0.8331667, size.height * 0.9800000);
    path0.lineTo(size.width * 0.8333333, size.height * 0.7000000);
    path0.lineTo(size.width * 0.6668333, size.height * 0.7000000);
    path0.lineTo(size.width * 0.6670333, size.height * 0.3000000);
    path0.lineTo(size.width * 0.8333333, size.height * 0.3000000);
    path0.lineTo(size.width * 0.8333333, size.height * 0.0180000);
    path0.lineTo(size.width * 0.9939333, size.height * 0.4985000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
