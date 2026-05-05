import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_under_the_hood/custom_painter_usage/smiley_face.dart';

void main() {
  testWidgets('smiley_face Golden test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmileyFaceApp());

    await tester.pumpAndSettle();

    final finder = find.byWidgetPredicate(
      (widget) => widget is CustomPaint && widget.painter is SmileyFace,
    );

    /// ## Why not search for `CustomPainter`?
    ///
    /// Because `CustomPainter` is **not a widget**, it’s just a painting delegate:
    ///
    /// ```dart
    /// abstract class CustomPainter extends Listenable
    /// ```
    ///
    /// It does not exist in the widget tree, so it cannot be found using
    /// `find.byType`.
    ///
    /// ## Why use a predicate instead of `find.byType(CustomPaint)`?
    ///
    /// The widget tree may contain multiple `CustomPaint` widgets
    /// (including ones used internally by `MaterialApp` or other widgets).
    ///
    /// To avoid matching unrelated painters, we narrow the search
    /// to a `CustomPaint` whose `painter` is specifically a `SmileyFace`.

    await expectLater(finder, matchesGoldenFile('golden_smiley_face.png'));
  });
}
