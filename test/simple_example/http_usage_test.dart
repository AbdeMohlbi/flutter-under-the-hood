import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_under_the_hood/simple_examples/http_usage.dart';

void main() {
  group("http example widget tests", () {
    testWidgets('Displays list of posts when data is loaded successfully', (
      tester,
    ) async {
      await tester.pumpWidget(HttpUsage(repository: MockUserSuccess()));

      // loading state
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FutureBuilder<List<Post>>), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      // fetched data successfully
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FutureBuilder<List<Post>>), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsAtLeast(1));
      expect(find.byType(Text), findsAtLeast(2));

      expect(find.text('Fake Post 1'), findsOneWidget);
      expect(find.text('Fake Post 2'), findsOneWidget);
    });

    testWidgets('displays error message when data loading fails', (
      tester,
    ) async {
      await tester.pumpWidget(HttpUsage(repository: MockUserFailure()));

      // loading state
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FutureBuilder<List<Post>>), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      // failed to fetch data
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FutureBuilder<List<Post>>), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Text), findsAtLeast(2));
    });
  });
}

class MockUserSuccess implements UserRepository {
  @override
  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return const [
      Post(id: 1, title: 'Fake Post 1', body: 'This is fake data for testing'),
      Post(id: 2, title: 'Fake Post 2', body: 'Another fake post'),
    ];
  }
}

class MockUserFailure implements UserRepository {
  @override
  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));

    throw Exception('something went wrong');
  }
}
