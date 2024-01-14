import 'package:flutter/material.dart';
import 'package:kahve/product/model/main_view_model/search_model/search_model.dart';
import 'package:kahve/product/router/main_view_router/search_router/search_router.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainSearchBase<T extends StatefulWidget> extends State<T> {
  // router service
  SearchRouterService routerService = SearchRouterService();

  // model service
  SearchModelService modelService = SearchModelService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;
}
