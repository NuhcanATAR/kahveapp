import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: context.padding.normal,
        child: ListView(
          children: <Widget>[
            // title
            // sub title
            // email
            // password
            // remember me & forgot password
            // login button
            // or
            // register button
          ],
        ),
      ),
    );
  }
}
