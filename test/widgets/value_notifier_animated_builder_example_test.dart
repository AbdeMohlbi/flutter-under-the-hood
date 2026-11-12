import 'package:flutter_under_the_hood/value_notifier_animated_builder_example/value_notifier_animated_builder_example.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('counter increments when button is pressed', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CounterIncrementExample()));

    expect(find.text('Counter: 0'), findsOneWidget);

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(find.text('Counter: 1'), findsOneWidget);

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(find.text('Counter: 2'), findsOneWidget);
  });

  testWidgets('only AnimatedBuilder rebuilds when counter changes', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: CounterIncrementExample()));

    expect(ValueNotifierAnimatedBuilderExampleWatcher.fullBuildsCount, 1);
    expect(
      ValueNotifierAnimatedBuilderExampleWatcher.animatedBuilderBuildsCount,
      1,
    );

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(ValueNotifierAnimatedBuilderExampleWatcher.fullBuildsCount, 1);
    expect(
      ValueNotifierAnimatedBuilderExampleWatcher.animatedBuilderBuildsCount,
      2,
    );

    expect(find.text('Counter: 1'), findsOneWidget);

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(ValueNotifierAnimatedBuilderExampleWatcher.fullBuildsCount, 1);
    expect(
      ValueNotifierAnimatedBuilderExampleWatcher.animatedBuilderBuildsCount,
      3,
    );
  });
}
