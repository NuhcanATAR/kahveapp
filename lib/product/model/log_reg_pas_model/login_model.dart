import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginViewModelService {
  // form key
  final formLoginKey = GlobalKey<FormState>();

  // controller
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  // validator
  String? emailValidator(String? emailVal) {
    if (emailVal == null || emailVal.isEmpty) {
      return "Zorunlu Alan";
    }
    return null;
  }

  String? passwordValidator(String? passVal) {
    if (passVal == null || passVal.isEmpty) {
      return "Zorunlu Alan";
    }
    return null;
  }

  // input
  bool isEmailinp = false;
  bool isPasswordinp = false;

  // password open / close
  bool isPassObscured = true;

  // remember me check
  bool isRememberChecked = false;

  // connectivity controller
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertDialog = false;

  // logger
  dynamic logger = Logger();
}
