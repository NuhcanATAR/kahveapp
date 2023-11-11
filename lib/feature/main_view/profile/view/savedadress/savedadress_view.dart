import 'package:flutter/material.dart';

class SavedAdressView extends StatefulWidget {
  const SavedAdressView({super.key});

  @override
  State<SavedAdressView> createState() => _SavedAdressViewState();
}

class _SavedAdressViewState extends State<SavedAdressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıtlı Adresler"),
      ),
    );
  }
}
