import 'dart:math';
import 'package:flutter/material.dart';

class BoundedProgressPainterApp extends StatelessWidget {
  const BoundedProgressPainterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _BoundedProgressPainterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _BoundedProgressPainterPage extends StatefulWidget {
  const _BoundedProgressPainterPage();

  @override
  State<_BoundedProgressPainterPage> createState() =>
      _BoundedProgressPainterPageState();
}

class _BoundedProgressPainterPageState
    extends State<_BoundedProgressPainterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.addListener(() {
      if (_controller.value >= 0.9) {
        _controller.stop();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomPainter Progress')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              size: const Size(200, 200),
              painter: BoundedProgressPainter(_controller.value),
            );
          },
        ),
      ),
    );
  }
}

class BoundedProgressPainter extends CustomPainter {
  final double progress;

  BoundedProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc (progress)
    final progressPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(
      rect,
      -pi / 2, // start from top
      2 * pi * progress,
      false,
      progressPaint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(progress * 100).toStringAsFixed(3)}%',
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant BoundedProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
