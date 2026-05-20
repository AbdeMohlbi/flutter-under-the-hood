import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/widgets/indexed_stack.dart';

void main() {
  testWidgets('TextEditingController is disposed when widget is removed', (
    WidgetTester tester,
  ) async {
    // 1. Wrap the widget in a way that we can remove it (using a toggle)
    bool showWidget = true;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: showWidget
                  ? const IndexedStackExample()
                  : const SizedBox.shrink(),
              floatingActionButton: FloatingActionButton(
                onPressed: () => setState(() => showWidget = false),
                child: const Icon(Icons.remove),
              ),
            );
          },
        ),
      ),
    );

    // 2. Find the State object to access the controller
    final state = tester.state<IndexedStackExampleState>(
      find.byType(IndexedStackExample),
    );
    final controller = state.fieldText;

    // Verify it's working initially
    expect(find.byType(TextField), findsOneWidget);

    // 3. Trigger the removal of the widget
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Rebuild with SizedBox.shrink()

    // 4. Verify widget is gone
    expect(find.byType(TextField), findsNothing);

    // 5. Verify Disposal
    // Accessing 'values' or adding listeners on a disposed controller throws a FlutterError
    expect(() => controller.addListener(() {}), throwsFlutterError);
  });
}
