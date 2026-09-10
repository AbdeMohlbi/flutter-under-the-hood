import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A signature for a builder that can return a null Widget.
typedef NullableTransitionBuilder = Widget? Function(
  BuildContext context,
  Widget? child,
);

class AnimatedNullableListenableBuilder extends StatefulWidget {
  const AnimatedNullableListenableBuilder({
    super.key,
    required this.listenable,
    required this.builder,
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
  });

  final Listenable listenable;
  final NullableTransitionBuilder builder;
  final Widget? child;

  /// The duration of the transition animation.
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  @override
  State<AnimatedNullableListenableBuilder> createState() =>
      _AnimatedNullableListenableBuilderState();
}

class _AnimatedNullableListenableBuilderState
    extends State<AnimatedNullableListenableBuilder> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(AnimatedNullableListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Widget? built = widget.builder(context, widget.child);

    return AnimatedSwitcher(
      duration: widget.duration,
      switchInCurve: widget.switchInCurve,
      switchOutCurve: widget.switchOutCurve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        // SizeTransition dynamically animates the space shrinking/expanding,
        // while FadeTransition handles the visual fade in/out.
        return SizeTransition(
          sizeFactor: animation,
          alignment: .center,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: _OptionalChildWidget(
        // The Key is essential for AnimatedSwitcher to detect changes.
        // It falls back to the runtime type so swapping to 'Null' triggers the animation.
        key: built?.key ?? ValueKey(built?.runtimeType),
        child: built,
      ),
    );
  }
}

class _OptionalChildWidget extends SingleChildRenderObjectWidget {
  const _OptionalChildWidget({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderOptionalBox();
  }
}

class _RenderOptionalBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    if (child != null) {
      // If we have a child, we pass down the constraints and adopt its size.
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      // If we don't have a child, we shrink to the smallest allowed size
      // (which is Size.zero unless forced by a parent like Expanded).
      // ie: using `size = Size.zero` is correct but wont work when dealing with
      // flexible widgets
      size = constraints.smallest;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child != null) {
      return child!.getDryLayout(constraints);
    } else {
      return constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
    // If null, we simply paint nothing.
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child != null) {
      return child!.hitTest(result, position: position);
    }
    return false;
  }
}

class AnimatedNullableListenableBuilderApp extends StatelessWidget {
  const AnimatedNullableListenableBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<bool> _showBox = ValueNotifier(true);

  @override
  void dispose() {
    _showBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nullable Builder Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => _showBox.value = !_showBox.value,
              child: const Text('Toggle Box'),
            ),

            AnimatedNullableListenableBuilder(
              listenable: _showBox,
              duration: const Duration(milliseconds: 400),
              builder: (context, child) {
                if (_showBox.value) {
                  return Container(
                    key: const ValueKey('my_blue_box'),
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text(
                      'I am here!',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return null;
              },
            ),
            const Text('Notice how the spacing above dynamically adjusts.'),
          ],
        ),
      ),
    );
  }
}
