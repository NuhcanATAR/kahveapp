import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/orderdetail/orderdetail_view.dart';

class OrderServiceRouter {
  // order detail view
  void orderDetailViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailView(
          data: data,
        ),
      ),
    );
  }
}
