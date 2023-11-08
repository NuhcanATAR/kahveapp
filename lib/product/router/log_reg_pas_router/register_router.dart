import 'package:flutter/material.dart';
import 'package:kahve/feature/log_reg_pass/register/view/agreement_view.dart';

class RegisterNavigatorRouterService {
  void kahveAgreementViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AgreementView(),
      ),
    );
  }
}
