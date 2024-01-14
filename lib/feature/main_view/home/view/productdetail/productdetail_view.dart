import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Detay"),
      ),
    );
  }
}
