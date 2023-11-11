import 'package:flutter/material.dart';
import 'package:kahve/product/router/main_view_router/profile_router/profile_router.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainProfileBase<T extends StatefulWidget> extends State<T>
    with ProfileRouterService {
  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;
}
