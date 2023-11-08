import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/mixin/password_mixin.dart';
import 'package:kahve/product/model/log_reg_pas_model/password_model.dart';
import 'package:kahve/product/router/log_reg_pas_router/password_router.dart';
import 'package:kartal/kartal.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainForgotPasswordBase<T extends StatefulWidget> extends State<T>
    with passwordMixin {
  // router service
  PasswordNavigatorRouterService routerService =
      PasswordNavigatorRouterService();

  // password model
  PasswordModelService modelService = PasswordModelService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  Future<void> resetPasswordBase() async {
    FirebaseAuth.instance
        .sendPasswordResetEmail(
          email: modelService.emailController.text.toString(),
        )
        .then((value) => {
              emailFalseAlert(context.general, context),
              modelService.emailController.clear(),
            })
        .catchError((err) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Email Adresi Hatalı!"),
                  action: SnackBarAction(
                    label: "Tamam",
                    onPressed: () {},
                  ),
                  duration: const Duration(
                    seconds: 3,
                  ),
                ),
              ),
              modelService.emailController.clear(),
            });
  }
}
