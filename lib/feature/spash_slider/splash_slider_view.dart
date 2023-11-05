import 'package:flutter/material.dart';

class SplashSliderView extends StatefulWidget {
  const SplashSliderView({super.key});

  @override
  State<SplashSliderView> createState() => _SplashSliderViewState();
}

class _SplashSliderViewState extends State<SplashSliderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider"),
      ),
    );
  }
}
