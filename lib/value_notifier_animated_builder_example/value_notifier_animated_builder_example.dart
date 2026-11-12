import 'package:material_ui/material_ui.dart';

class ValueNotifierAnimatedBuilderExample extends StatelessWidget {
  const ValueNotifierAnimatedBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterIncrementExample());
  }
}

class CounterIncrementExample extends StatefulWidget {
  const CounterIncrementExample({super.key});

  @override
  State<CounterIncrementExample> createState() =>
      _CounterIncrementExampleState();
}

class _CounterIncrementExampleState extends State<CounterIncrementExample> {
  final ValueNotifier<int> counter = ValueNotifier(0);

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifierAnimatedBuilderExampleWatcher.increaseFullBuildsCount();
    debugPrint("FULL BUILD");

    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedBuilder Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This part does NOT rebuild"),

            const SizedBox(height: 20),

            AnimatedBuilder(
              animation: counter,
              builder: (context, child) {
                ValueNotifierAnimatedBuilderExampleWatcher.increaseAnimatedBuilderBuildsCount();
                debugPrint("ONLY TEXT REBUILDS");
                return Text(
                  'Counter: ${counter.value}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
sealed class ValueNotifierAnimatedBuilderExampleWatcher {
  static int _fullBuildsCount = 0;
  static int _animatedBuilderBuildsCount = 0;

  static void increaseFullBuildsCount() => _fullBuildsCount++;
  static void increaseAnimatedBuilderBuildsCount() =>
      _animatedBuilderBuildsCount++;

  static int get fullBuildsCount => _fullBuildsCount;
  static int get animatedBuilderBuildsCount => _animatedBuilderBuildsCount;
}
