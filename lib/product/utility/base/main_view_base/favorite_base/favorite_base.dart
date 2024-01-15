import 'package:flutter/material.dart';
import 'package:kahve/product/router/main_view_router/home_router/home_router.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainFavoriteBase<T extends StatefulWidget> extends State<T> {
  // router service
  HomeRouterService routerService = HomeRouterService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;
}
