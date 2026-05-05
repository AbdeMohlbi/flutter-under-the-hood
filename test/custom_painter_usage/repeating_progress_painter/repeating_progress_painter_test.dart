import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/custom_painter_usage/repeating_progress_indicator.dart';

void main() {
  group("Widget tests", () {
    testWidgets('All expected widgets are present', (tester) async {
      await tester.pumpWidget(RepeatingProgressIndicatorApp());

      await tester.pump();
      //
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(AnimatedBuilder), findsAtLeast(1));
      expect(
        find.byType(CustomPaint),
        findsAny,
      ); // RepeatingProgressPainter plus one somewhere in MateriaApp
      expect(
        find.byType(RepeatingProgressPainter),
        findsNothing,
      ); // because CustomPainter is not a widget
    });
  });
}
