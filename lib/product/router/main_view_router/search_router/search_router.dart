import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/home/view/productdetail/productdetail_view.dart';

class SearchRouterService {
  // product detail view router
  void productDetailViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailView(
          data: data,
        ),
      ),
    );
  }
}
