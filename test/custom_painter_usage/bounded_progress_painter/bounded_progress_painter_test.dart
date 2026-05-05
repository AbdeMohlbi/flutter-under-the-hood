import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/custom_painter_usage/bounded_progress_painter.dart';

void main() {
  group("Widget tests", () {
    testWidgets('All expected widgets are present', (tester) async {
      await tester.pumpWidget(BoundedProgressPainterApp());

      await tester.pump();
      //
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(AnimatedBuilder), findsAtLeast(1));
      expect(
        find.byType(CustomPaint),
        findsAny,
      ); // ProgressPainter plus one somewhere in MateriaApp
      expect(
        find.byType(BoundedProgressPainter),
        findsNothing,
      ); // because CustomPainter is not a widget
    });
  });
}
