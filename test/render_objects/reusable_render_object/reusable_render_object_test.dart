import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/render_objects/reusable_render_object.dart';

void main() {
  group("Widget tests", () {
    testWidgets(
      'only one MyRenderObjectWidget exists before and after the counter changes',
      (tester) async {
        await tester.pumpWidget(ReusableRenderObjectApp());

        await tester.pump();

        expect(find.byType(MyRenderObjectWidget), findsOneWidget);

        final buttonFinder = find.byType(ElevatedButton);

        await tester.tap(buttonFinder);
        await tester.pump();

        expect(find.byType(MyRenderObjectWidget), findsOneWidget);
      },
    );
  });
  testWidgets('RenderObject is reused while widget is recreated', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ReusableRenderObjectApp());

    final firstWidget = tester.widget<MyRenderObjectWidget>(
      find.byType(MyRenderObjectWidget),
    );

    final firstRenderObject = tester.renderObject<MyRenderObject>(
      find.byType(MyRenderObjectWidget),
    );

    expect(firstRenderObject, isNotNull);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    final secondWidget = tester.widget<MyRenderObjectWidget>(
      find.byType(MyRenderObjectWidget),
    );

    final secondRenderObject = tester.renderObject<MyRenderObject>(
      find.byType(MyRenderObjectWidget),
    );

    // ✅ 1. Widgets are NOT the same instance (new widget created)
    expect(identical(firstWidget, secondWidget), isFalse);

    // ✅ 2. RenderObject IS the same instance (reused)
    expect(identical(firstRenderObject, secondRenderObject), isTrue);

    // ✅ 3. Optional sanity check: value updated correctly
    expect(secondRenderObject.value, 1);
  });
}
