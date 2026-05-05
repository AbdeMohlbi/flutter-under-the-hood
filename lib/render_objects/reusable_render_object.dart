// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

/// This is a simple example that demonstrates that RenderObjects are long-lived.
/// Even when a widget is rebuilt (new instance in the Widget Tree),
/// Flutter reuses the same RenderObject as long as the widget type (and key) stays the same.
/// Only the values are updated through updateRenderObject.

class ReusableRenderObjectApp extends StatefulWidget {
  const ReusableRenderObjectApp({super.key});

  @override
  State<ReusableRenderObjectApp> createState() =>
      _ReusableRenderObjectAppState();
}

class _ReusableRenderObjectAppState extends State<ReusableRenderObjectApp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    print(
      '🟢 ReusableRenderObjectApp.build() - new widget instance with counter=$counter',
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('RenderObject Proof')),
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 20,
            children: [
              MyRenderObjectWidget(value: counter),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
                child: const Text('Rebuild'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyRenderObjectWidget extends LeafRenderObjectWidget {
  const MyRenderObjectWidget({super.key, required this.value});
  final int value;

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('🔵 createRenderObject() called with value=$value');
    return MyRenderObject(value);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant MyRenderObject renderObject,
  ) {
    print('🟡 updateRenderObject() called with value=$value');
    renderObject.value = value;
  }
}

class MyRenderObject extends RenderBox {
  MyRenderObject(this._value) {
    print('🟣 RenderObject CONSTRUCTOR called with value=$_value');
  }
  int _value;

  int get value => _value;

  set value(int newValue) {
    if (_value != newValue) {
      print('🔴 RenderObject value updated: $_value -> $newValue');
      _value = newValue;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    size = const Size(150, 50);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final paint = Paint()..color = Colors.blue;

    canvas.drawRect(offset & size, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Value: $_value',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      textDirection: .ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      offset + Offset(10, (size.height - textPainter.height) / 2),
    );
  }
}
