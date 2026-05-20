import 'package:flutter/material.dart';

class InheritedWidgetExample extends StatefulWidget {
  const InheritedWidgetExample({super.key});

  @override
  State<InheritedWidgetExample> createState() => _MyAppState();
}

class _MyAppState extends State<InheritedWidgetExample> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: counter,
      increment: increment,
      child: const MaterialApp(home: HomePage()),
    );
  }
}

class CounterProvider extends InheritedWidget {
  final int counter;
  final VoidCallback increment;

  const CounterProvider({
    super.key,
    required this.counter,
    required this.increment,
    required super.child,
  });

  static CounterProvider of(BuildContext context) {
    final CounterProvider? result = context
        .dependOnInheritedWidgetOfExactType<CounterProvider>();
    assert(result != null, 'No CounterProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.counter != counter;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('InheritedWidget Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Counter: ${provider.counter}',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            const ChildWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Text(
      'Child sees counter: ${provider.counter}',
      style: const TextStyle(fontSize: 18),
    );
  }
}
