import 'package:flutter/material.dart';

class PasswordModelService {
  // form key
  final formResPasswordKey = GlobalKey<FormState>();

  // controller
  late TextEditingController emailController = TextEditingController();

  // validator
  String? emailValidator(String? emailVal) {
    if (emailVal == null || emailVal.isEmpty) {
      return "* Zorunlu Alan";
    }
    return null;
  }
}
