import 'dart:math';
import 'package:flutter/material.dart';

class RepeatingProgressIndicatorApp extends StatelessWidget {
  const RepeatingProgressIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const _RepeatingProgressPage(),
    );
  }
}

class _RepeatingProgressPage extends StatefulWidget {
  const _RepeatingProgressPage();

  @override
  State<_RepeatingProgressPage> createState() => _RepeatingProgressState();
}

class _RepeatingProgressState extends State<_RepeatingProgressPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              size: const Size(220, 220),
              painter: RepeatingProgressPainter(progress: _controller.value),
            );
          },
        ),
      ),
    );
  }
}

class RepeatingProgressPainter extends CustomPainter {
  final double progress;

  RepeatingProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2 - 20;

    final backgroundPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [Colors.purple, Colors.blue, Colors.cyan],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..color = Colors.blue.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    // Background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Glow effect (behind arc)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      glowPaint,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );

    // Center text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(progress * 100).round()}%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant RepeatingProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
