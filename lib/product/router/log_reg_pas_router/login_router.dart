import 'package:flutter/material.dart';
import 'package:kahve/feature/log_reg_pass/login/view/loginrouter_view.dart';
import 'package:kahve/feature/log_reg_pass/password/password_view.dart';
import 'package:kahve/feature/main_view/bottommenu_view/bottommenu_view.dart';

class LoginViewRouterService {
  void loginControlRouterViewNavigatorRouter(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginRouterView(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  // forgot password router
  void forgotPasswordNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordView(),
      ),
    );
  }
}

mixin loginMainRouter {
  void loginMainBottomMenuNavigator(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomMenuView(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
