import 'package:flutter/material.dart';

import '../../extension/extension.dart';

class Dot extends StatelessWidget {
  const Dot({
    super.key,
    this.size = 2,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _DotPainter(size / 2, color ?? context.color.whiteOpacity5),
        size: Size(size, size),
      );
}

class _DotPainter extends CustomPainter {
  _DotPainter(this.radius, this.color);

  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
