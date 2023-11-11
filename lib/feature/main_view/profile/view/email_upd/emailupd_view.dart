import 'package:flutter/material.dart';

class EmailUpdView extends StatefulWidget {
  const EmailUpdView({super.key});

  @override
  State<EmailUpdView> createState() => _EmailUpdViewState();
}

class _EmailUpdViewState extends State<EmailUpdView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Güncelle"),
      ),
    );
  }
}
