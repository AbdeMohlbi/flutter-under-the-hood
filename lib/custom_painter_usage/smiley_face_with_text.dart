import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

class SmileyFaceWithText extends StatelessWidget {
  const SmileyFaceWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Painter Smile')),
        body: Center(
          child: CustomPaint(
            size: const Size(300, 300),
            painter: SmilePainter(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw face
    final facePaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, facePaint);

    // Draw mouth
    final smilePaint = Paint()
      ..style = .stroke
      ..strokeWidth = 10
      ..color = Colors.black;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius / 2),
      0,
      math.pi,
      false,
      smilePaint,
    );

    // Draw left eye
    canvas.drawCircle(
      Offset(center.dx - radius / 2.5, center.dy - radius / 2.5),
      10,
      Paint()..color = Colors.black,
    );

    // Draw right eye
    canvas.drawCircle(
      Offset(center.dx + radius / 2.5, center.dy - radius / 2.5),
      10,
      Paint()..color = Colors.black,
    );

    // -------- TEXT USING drawParagraph --------
    final paragraphStyle = ui.ParagraphStyle(
      textAlign: .center,
      fontSize: 20,
      maxLines: 2,
    );

    final textStyle = ui.TextStyle(color: Colors.black, fontWeight: .bold);

    final builder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('Hello 👋');

    final paragraph = builder.build();

    // Layout paragraph with a max width
    paragraph.layout(ui.ParagraphConstraints(width: radius * 1.5));

    // Center the text inside the face
    final textOffset = Offset(
      center.dx - paragraph.width / 2,
      center.dy - paragraph.height / 2,
    );

    canvas.drawParagraph(paragraph, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
