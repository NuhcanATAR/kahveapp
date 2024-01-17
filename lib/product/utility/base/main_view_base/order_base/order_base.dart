import 'package:flutter/material.dart';
import 'package:kahve/product/router/main_view_router/order_router/order_router.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainOrderBase<T extends StatefulWidget> extends State<T> {
  // router service
  OrderServiceRouter routerService = OrderServiceRouter();
  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;
}
