import 'dart:math' as math;

import 'package:flutter/material.dart';

class SmileyFaceApp extends StatelessWidget {
  const SmileyFaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Painter Playground',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const _SmileyFacePage(),
    );
  }
}

class _SmileyFacePage extends StatefulWidget {
  const _SmileyFacePage();

  @override
  State<_SmileyFacePage> createState() => _SmileyFacePageState();
}

class _SmileyFacePageState extends State<_SmileyFacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            CustomPaint(
              size: .square(120),
              painter: SmileyFace(color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}

class SmileyFace extends CustomPainter {
  final Color color;

  SmileyFace({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the body
    final paint = Paint()..color = color;
    canvas.drawCircle(center, radius, paint);

    // Draw the mouth
    final smilePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius / 2),
      0,
      math.pi,
      false,
      smilePaint,
    );

    // Draw the eyes
    canvas.drawCircle(
      Offset(center.dx - radius / 2, center.dy - radius / 2),
      10,
      Paint(),
    );

    canvas.drawCircle(
      Offset(center.dx + radius / 2, center.dy - radius / 2),
      10,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
