import 'package:flutter/material.dart';
import 'package:kahve/feature/splash/splash.dart';

void main() async {
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
