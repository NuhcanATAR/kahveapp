import 'package:flutter/material.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Listesi"),
      ),
    );
  }
}
