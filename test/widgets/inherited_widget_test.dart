import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/widgets/inherited_widget.dart';

void main() {
  group('InheritedWidgetExample', () {
    testWidgets('displays initial counter value in both widgets', (
      WidgetTester tester,
    ) async {
      // Pump the widget.
      await tester.pumpWidget(const InheritedWidgetExample());

      // Verify initial counter values.
      expect(find.text('Counter: 0'), findsOneWidget);
      expect(find.text('Child sees counter: 0'), findsOneWidget);

      // Verify FAB exists.
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('increments counter when FAB is tapped', (
      WidgetTester tester,
    ) async {
      // Pump the widget.
      await tester.pumpWidget(const InheritedWidgetExample());

      // Verify initial state.
      expect(find.text('Counter: 0'), findsOneWidget);
      expect(find.text('Child sees counter: 0'), findsOneWidget);

      // Tap the FAB.
      await tester.tap(find.byType(FloatingActionButton));

      // Rebuild after state change.
      await tester.pump();

      // Verify updated values.
      expect(find.text('Counter: 1'), findsOneWidget);
      expect(find.text('Child sees counter: 1'), findsOneWidget);
    });

    testWidgets('increments multiple times correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const InheritedWidgetExample());

      final fabFinder = find.byType(FloatingActionButton);

      // Tap 3 times.
      await tester.tap(fabFinder);
      await tester.pump();

      await tester.tap(fabFinder);
      await tester.pump();

      await tester.tap(fabFinder);
      await tester.pump();

      // Verify final state.
      expect(find.text('Counter: 3'), findsOneWidget);
      expect(find.text('Child sees counter: 3'), findsOneWidget);
    });
  });
}
