import 'package:flutter/widgets.dart';

enum ImgLogoConstants {
  appLogo('applogo');

  final String value;
  const ImgLogoConstants(this.value);
  String get toPng => "assets/images/splash_img/$value.png";
  Image get toImg => Image.asset(toPng);
}

enum AppSplashSliderImgConstant {
  appSliderImg1('sliderimg1'),
  appSliderImg2('sliderimg2'),
  appSliderImg3('sliderimg3'),
  appSliderImg4('sliderimg4'),
  appSliderImg5('sliderimg5');

  final String value;
  const AppSplashSliderImgConstant(this.value);

  String get toPng => "assets/images/slider_img/$value.png";
  Image get toImg => Image.asset(toPng);
}
