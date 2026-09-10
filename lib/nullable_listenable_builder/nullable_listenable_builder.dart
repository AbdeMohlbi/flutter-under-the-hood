import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A signature for a builder that can return a null Widget.
typedef NullableTransitionBuilder = Widget? Function(
  BuildContext context,
  Widget? child,
);

class NullableListenableBuilder extends StatefulWidget {
  const new({
    super.key,
    required this.listenable,
    required this.builder,
    this.child,
  });

  final Listenable listenable;
  final NullableTransitionBuilder builder;
  final Widget? child;

  @override
  State<NullableListenableBuilder> createState() =>
      _NullableListenableBuilderState();
}

class _NullableListenableBuilderState extends State<NullableListenableBuilder> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(NullableListenableBuilder oldWidget) {
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
    // We execute the user's builder which may return null.
    final Widget? built = widget.builder(context, widget.child);

    // We pass the potentially null widget to our custom RenderObjectWidget.
    return _OptionalChildWidget(child: built);
  }
}

/// A widget that safely houses a nullable child at the element/render tree layer.
class _OptionalChildWidget extends SingleChildRenderObjectWidget {
  const new({super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderOptionalBox();
  }
}

/// A custom RenderBox that safely handles a null child.
/// If there is no child, it takes up the minimum space dictated by the parent's constraints.
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
    // If null, it cannot be interacted with.
    return false;
  }
}

class NullableListenableBuilderApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const new({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showBox.value = !_showBox.value,
              child: const Text('Toggle Box'),
            ),
            const SizedBox(height: 20),
            NullableListenableBuilder(
              listenable: _showBox,
              builder: (context, child) {
                // If true, return the UI
                if (_showBox.value) {
                  return Container(
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
                // If false, return null
                return null;
              },
            ),

            const SizedBox(height: 20),
            const Text('Notice how the spacing above dynamically adjusts.'),
          ],
        ),
      ),
    );
  }
}
