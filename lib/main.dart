import 'package:flutter/material.dart';

import 'custom_painter_usage/bounded_progress_painter.dart';
import 'custom_painter_usage/repeating_progress_indicator.dart';
import 'render_objects/reusable_render_object.dart';
import 'custom_painter_usage/smiley_face.dart';

const widgets = [
  SmileyFaceApp(),
  RepeatingProgressIndicatorApp(),
  BoundedProgressPainterApp(),
  ReusableRenderObjectApp(),
];

void main() {
  runApp(ReusableRenderObjectApp());
}
