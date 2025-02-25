import 'dart:math';
import 'package:flutter/material.dart';

class BackgroundShapes extends StatelessWidget {
  final String gender;
  final List<Widget> shapes;

  const BackgroundShapes({super.key, required this.gender, required this.shapes});

  @override
  Widget build(BuildContext context) {
    return Stack(children: shapes);
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.4;

    for (int i = 0; i < 5; i++) {
      final outerAngle = 2 * pi * i / 5; // Use pi from dart:math
      final innerAngle = outerAngle + pi / 5; // Ajuste para 5 pontas
      if (i == 0) {
        path.moveTo(
          centerX + outerRadius * cos(outerAngle),
          centerY + outerRadius * sin(outerAngle),
        );
      } else {
        path.lineTo(
          centerX + outerRadius * cos(outerAngle),
          centerY + outerRadius * sin(outerAngle),
        );
      }
      path.lineTo(
        centerX + innerRadius * cos(innerAngle),
        centerY + innerRadius * sin(innerAngle),
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}