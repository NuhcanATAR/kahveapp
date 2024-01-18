// ignore_for_file: use_build_context_synchronously

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/noconnection/noconnection_view.dart';
import 'package:kahve/product/router/main_view_router/home_router/home_router.dart';
import 'package:logger/logger.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainFavoriteBase<T extends StatefulWidget> extends State<T> {
  // router service
  HomeRouterService routerService = HomeRouterService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  @override
  void initState() {
    super.initState();
    setState(() {
      checkControl();
    });
  }

  void checkControl() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      Logger().i("İnternet Bağlandı!!");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NoConnectionErrorView(),
        ),
      );
    }
  }
}
