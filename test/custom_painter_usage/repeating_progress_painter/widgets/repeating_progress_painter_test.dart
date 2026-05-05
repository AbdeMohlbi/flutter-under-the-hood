import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/custom_painter_usage/repeating_progress_indicator.dart';

void main() {
  testWidgets('repeating_progress_painter golden test', (tester) async {
    await tester.pumpWidget(const RepeatingProgressIndicatorApp());

    // ------------------------------------------------------------
    // WHY we do NOT use `pumpAndSettle()` here:
    //
    // The animation inside `RepeatingProgress` is infinite:
    //   _controller.repeat(reverse: true);
    //
    // This means there is ALWAYS a next frame scheduled.
    // So `pumpAndSettle()` would never complete (it waits for
    // the UI to become "idle", which never happens here).
    //
    // ------------------------------------------------------------
    // Instead, we manually advance the animation to a deterministic
    // point in time so the golden test becomes stable and repeatable.
    // ------------------------------------------------------------

    // Advance to a specific frame (e.g. ~50%)
    await tester.pump(const Duration(milliseconds: 1500));

    final finder = find.byWidgetPredicate(
      (widget) =>
          widget is CustomPaint && widget.painter is RepeatingProgressPainter,
    );

    await expectLater(
      finder,
      matchesGoldenFile('golden_repeating_progress_50.png'),
    );
  });
}
