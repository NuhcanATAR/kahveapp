import 'package:flutter/material.dart';
import 'package:kahve/feature/spash_slider/splash_slider_view.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 4,
      ),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashSliderView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutQuart;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorBackgroundConstant.brownDarker,
      body: Center(
        child: buildLogoWidget,
      ),
    );
  }

  // logo
  Widget get buildLogoWidget => Padding(
        padding: const EdgeInsets.all(80),
        child: ImgLogoConstants.appLogo.toImg,
      );
}
