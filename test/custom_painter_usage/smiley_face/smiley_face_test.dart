import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/custom_painter_usage/smiley_face.dart';

void main() {
  group("Widget tests", () {
    testWidgets('All expected widgets are present', (tester) async {
      await tester.pumpWidget(SmileyFaceApp());

      await tester.pump();
      //
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(
        find.byType(CustomPaint),
        findsAny,
      ); // smiley face plus one somewhere in MateriaApp
      expect(
        find.byType(SmileyFace),
        findsNothing,
      ); // because CustomPainter is not a widget
    });
  });
}
