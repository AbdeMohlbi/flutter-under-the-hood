import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpUsage extends StatelessWidget {
  final UserRepository repository;

  const HttpUsage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostsPage(repository: repository),
    );
  }
}

class PostsPage extends StatefulWidget {
  final UserRepository repository;

  const PostsPage({super.key, required this.repository});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late final Future<List<Post>> _postsFuture = widget.repository.fetchPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Example')),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == .waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', textAlign: .center),
            );
          }

          final posts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body, maxLines: 2, overflow: .ellipsis),
              );
            },
          );
        },
      ),
    );
  }
}

class Post {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }
}

abstract class UserRepository {
  Future<List<Post>> fetchPosts();
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
