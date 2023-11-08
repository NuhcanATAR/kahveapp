// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/mixin/register_mixin.dart';
import 'package:kahve/product/model/log_reg_pas_model/register_model.dart';
import 'package:kahve/product/router/log_reg_pas_router/register_router.dart';
import 'package:kahve/product/utility/database/register_db/register_db.dart';

import 'package:kartal/kartal.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainRegisterBase<T extends StatefulWidget> extends State<T>
    with RegisterMixin {
  // router service
  RegisterNavigatorRouterService routerService =
      RegisterNavigatorRouterService();

  // model service
  RegisterModelService modelService = RegisterModelService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  Future<void> userRegister() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: modelService.emailController.text.toString(),
        password: modelService.passwordController.text.toString(),
      );

      await RegisterDb.USERS.userRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "ID": FirebaseAuth.instance.currentUser!.uid,
        "NAMESURNAME": modelService.nameSurnameController.text,
        "EMAIL": modelService.emailController.text,
        "PASSWORD": modelService.passwordController.text,
      }).then((value) {
        registerAlert(context.general, context);
        modelService.nameSurnameController.clear();
        modelService.emailController.clear();
        modelService.passwordController.clear();
      }).catchError((err) {
        emailAlert(context.general, context);
        modelService.nameSurnameController.clear();
        modelService.emailController.clear();
        modelService.passwordController.clear();
      });

      User? userAuth = userCredential.user;
      await userAuth?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emailAlert(context.general, context);
        modelService.nameSurnameController.clear();
        modelService.emailController.clear();
        modelService.passwordController.clear();
      }
    } catch (e) {
      modelService.logger.i(e);
    }
  }
}
