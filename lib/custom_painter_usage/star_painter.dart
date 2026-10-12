import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

class StarPainterApp extends StatelessWidget {
  const StarPainterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Star Painter')),
        body: Center(
          child: CustomPaint(
            size: const Size(300, 300),
            painter: StarPainter(),
          ),
        ),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final starPath = createStarPath(
      center: center,
      outerRadius: 120,
      innerRadius: 60,
      points: 5,
    );

    // 1. Draw the Fill (The orange inside)
    final fillPaint = Paint()
      ..color = Colors.orange
      ..style = .fill;
    canvas.drawPath(starPath, fillPaint);

    // 2. Draw the Border (The outline)
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = .stroke
      ..strokeWidth =
          4.0 // Adjust thickness here
      ..strokeJoin = .round; // Optional: Makes corners look smoother

    canvas.drawPath(starPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Path createStarPath({
  required Offset center,
  required double outerRadius,
  required double innerRadius,
  int points = 5,
}) {
  final path = Path();
  final angle = (math.pi * 2) / points;

  for (int i = 0; i < points; i++) {
    final outerX = center.dx + outerRadius * math.cos(i * angle - math.pi / 2);
    final outerY = center.dy + outerRadius * math.sin(i * angle - math.pi / 2);

    final innerX =
        center.dx + innerRadius * math.cos(i * angle + angle / 2 - math.pi / 2);
    final innerY =
        center.dy + innerRadius * math.sin(i * angle + angle / 2 - math.pi / 2);

    if (i == 0) {
      path.moveTo(outerX, outerY);
    } else {
      path.lineTo(outerX, outerY);
    }

    path.lineTo(innerX, innerY);
  }

  path.close();
  return path;
}
