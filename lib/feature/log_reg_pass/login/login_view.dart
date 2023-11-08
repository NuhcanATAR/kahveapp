import 'package:flutter/material.dart';
import 'package:kahve/feature/log_reg_pass/login/widget/centerbody_widget.dart';
import 'package:kahve/feature/log_reg_pass/login/widget/topbody_widget.dart';
import 'package:kahve/product/utility/base/log_reg_pass_base/login_base/login_base.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends MainLoginBase<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
      body: SizedBox(
        width: maxWidth,
        height: maxHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // top body
            buildTopBodyWidget,
            // center body
            buildCenterBodyWidget,
          ],
        ),
      ),
    );
  }

  // top body
  Widget get buildTopBodyWidget => TopBodyWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // center body
  Widget get buildCenterBodyWidget => CenterBodyWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
        routerService: routerService,
        loginModel: modelService,
        loginUser: loginUser,
      );
}
