import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/bottommenu_view/bottommenu_view.dart';

class LoginViewRouterService {
  void loginMainBottomMenuViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomMenuView(),
      ),
    );
  }
}
