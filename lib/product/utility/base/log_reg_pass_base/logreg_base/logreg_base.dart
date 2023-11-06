import 'package:flutter/material.dart';
import 'package:kahve/product/router/log_reg_pas_router/logreg_router.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainLogRegBase<T extends StatefulWidget> extends State<T> {
  // router service
  LoginRouterViewRouterService routerService = LoginRouterViewRouterService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;
}
