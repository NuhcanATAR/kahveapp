import 'package:flutter/material.dart';
import 'package:kahve/feature/splash/splash.dart';
import 'package:kahve/product/initialize/app_start.dart';

void main() async {
  await AppStart.initStart();
  runApp(
    const MainView(),
  );
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
