import 'package:flutter/material.dart';

class BlogDetailView extends StatefulWidget {
  const BlogDetailView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Detayı"),
      ),
    );
  }
}
