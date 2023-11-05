import 'package:flutter/widgets.dart';

enum ImgLogoConstants {
  appLogo('applogo');

  final String value;
  const ImgLogoConstants(this.value);
  String get toPng => "assets/images/splash_img/$value.png";
  Image get toImg => Image.asset(toPng);
}
