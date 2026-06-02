# flutter_under_the_hood

This repository contains practical examples of using [CustomPainter](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html) and
[RenderObject](https://api.flutter.dev/flutter/rendering/RenderObject-class.html)s. 

The goal is better understanding of how flutter frameworks works.

---

### Contents
- [CustomPainter](lib/custom_painter_usage/)
    - [SmileyFace](lib/custom_painter_usage/smiley_face.dart)
        - Draws a simple smiley face using `CustomPainter`
        - Demonstrates basic shapes like circles, arcs, and positioning

    - [BoundedProgressPainter](lib/custom_painter_usage/bounded_progress_painter.dart)
        - A custom animated progress indicator
        - Shows how `shouldRepaint` can return `true` or `false` depending on animation state
        - Useful for understanding performance optimization in custom painting

    - [RepeatingProgressPainter](lib/custom_painter_usage/repeating_progress_indicator.dart)
        - A custom animated progress indicator
        - Shows how to use repeat so the animation repeats indefinitely

- [RenderObject](lib/render_objects/)
    - [BoundedProgressPainter](lib/render_objects/reusable_render_object.dart)
    - A custom `LeafRenderObjectWidget` which uses a custom `RenderBox` (a class that extends `RenderObject`) implementation

- [SimpleExamples](lib/simple_examples)
    - [HttpUsage](lib/simple_examples/http_usage.dart)

- [widgets](lib/widgets)
    - [IndexedStack](lib/widgets/indexed_stack.dart)
    - [InheritedWidget](lib/widgets/inherited_widget.dart)
    
### Tests

- To update golden images, run:
```bash
  flutter test --update-goldens
```

### Additional ressources
- [Trig Coordinates Guide](trig-coordinates-guide.md)
  - A simple math guide explaining how `sin` and `cos` work in drawing
  - Covers how to position points on a circle using angles
  - Helps bridge math concepts with Flutter rendering

- [Flutter Three Trees](flutter-three-trees.md)
  - Explains the Widget, Element, and RenderObject trees in Flutter
  - Shows how Flutter separates configuration, identity, and rendering
  - Helps understand performance and why RenderObjects are reused

- [RenderObjectWidget Hierarchy](renderobjectwidget-hierarchy.md)
  - Explains Leaf, SingleChild, and MultiChild RenderObjectWidgets
  - Shows how Flutter connects Widgets to RenderObjects via create/update logic
  - Covers markNeedsLayout, markNeedsPaint, and rendering lifecycle basics
