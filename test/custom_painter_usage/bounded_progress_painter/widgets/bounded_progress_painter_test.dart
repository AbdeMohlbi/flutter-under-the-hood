import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/custom_painter_usage/bounded_progress_painter.dart';

void main() {
  testWidgets('progress_painter Golden test', (WidgetTester tester) async {
    await tester.pumpWidget(const BoundedProgressPainterApp());

    await tester.pumpAndSettle();

    final finder = find.byWidgetPredicate(
      (widget) =>
          widget is CustomPaint && widget.painter is BoundedProgressPainter,
    );

    await expectLater(
      finder,
      matchesGoldenFile('golden_bounded_progress_painter.png'),
    );
  });
}
