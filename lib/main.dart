import 'package:material_ui/material_ui.dart';

import 'animated_nullable_listenable_builder/animated_nullable_listenable_builder.dart';
import 'custom_painter_usage/bounded_progress_painter.dart';
import 'custom_painter_usage/repeating_progress_indicator.dart';
import 'custom_painter_usage/smiley_face.dart';
import 'nullable_listenable_builder/nullable_listenable_builder.dart';
import 'render_objects/reusable_render_object.dart';
import 'simple_examples/http_usage.dart';

const widgets = [
  SmileyFaceApp(),
  RepeatingProgressIndicatorApp(),
  BoundedProgressPainterApp(),
  ReusableRenderObjectApp(),
  NullableListenableBuilderApp(),
  AnimatedNullableListenableBuilderApp(),
];

final nonConstWidgets = [HttpUsage(repository: UserRepositoryImpl())];
void main() {
  runApp(widgets[4]);
}
