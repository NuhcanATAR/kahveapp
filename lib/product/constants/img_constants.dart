import 'package:flutter/widgets.dart';

enum AppMainImgConstant {
  appNoConnectionErrorImg('noconnection');

  final String value;
  const AppMainImgConstant(this.value);
  String get toPng => "assets/images/noconnection_img/$value.png";
  Image get toImg => Image.asset(toPng);
}

enum AppErrorImgConstant {
  appErrorImg('error_img');

  final String value;
  const AppErrorImgConstant(this.value);

  String get toPng => "assets/images/error_img/$value.png";
  Image get toImg => Image.asset(toPng);
}

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

enum AppLoginRegisterPasswordIconsConstant {
  registerSendEmailicon('icons8-sent-64'),
  registerEmailicon('icons8-email-64'),
  registerRegistericon('icons8-check-64'),
  loginUserNotFounticon('icons8-user-not-found-50'),
  loginPasswordFalseicon('icons8-wrong-password-50'),

  loginUserBannedicon('icons8-warning-50');

  final String value;
  const AppLoginRegisterPasswordIconsConstant(this.value);

  String get toPng => "assets/icons/register_icons/$value.png";
  Image get toImg => Image.asset(toPng);
}

enum AppProfileViewImagesConstant {
  emailUpdimg('undraw_into_the_night_vumi');

  final String value;
  const AppProfileViewImagesConstant(this.value);

  String get toPng => "assets/images/profile_img/$value.png";
  Image get toImg => Image.asset(toPng);
}

enum AppHomeViewImageConstant {
  profileIMG('account_img');

  final String value;
  const AppHomeViewImageConstant(this.value);

  String get toPng => "assets/images/home_img/$value.png";
  Image get toImg => Image.asset(toPng);
}
