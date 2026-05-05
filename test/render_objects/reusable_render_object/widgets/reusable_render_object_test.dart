import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/render_objects/reusable_render_object.dart';

void main() {
  testWidgets('Reusable RenderObject golden test', (WidgetTester tester) async {
    await tester.pumpWidget(const ReusableRenderObjectApp());

    // 🔹 Initial state (counter = 0)
    await expectLater(
      find.byType(ReusableRenderObjectApp),
      matchesGoldenFile('goldens/render_object_0.png'),
    );

    // 🔹 Tap button → counter = 1
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(ReusableRenderObjectApp),
      matchesGoldenFile('goldens/render_object_1.png'),
    );
  });
}
