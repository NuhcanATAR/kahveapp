import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RegisterModelService {
  // form key
  final formRegisterKey = GlobalKey<FormState>();

  // controller
  late TextEditingController nameSurnameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  // validator
  String? nameSurnameValidator(String? nameSurnameVal) {
    if (nameSurnameVal == null || nameSurnameVal.isEmpty) {
      return "Zorunlu Alan";
    }
    return null;
  }

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

  // password open / close
  bool isPassObscured = true;

  // logger
  dynamic logger = Logger();
}
