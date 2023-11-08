import 'package:flutter/material.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

mixin loginMixin {
  void userNotFound(BuildContext context, contextgeneral) {
    var alertUserNotFoundDialog = AlertDialog(
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.23,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: AppLoginRegisterPasswordIconsConstant
                    .loginUserNotFounticon.toImg,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: BodyMediumBlackBoldText(
                  text: "E-mail Adresi veya Şifre Hatalı",
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: LabelMediumGreyText(
                    text: "Bilgileriniz yanlış, Lütfen tekrar deneyiniz.",
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alertUserNotFoundDialog);
  }

  void wrongPassword(context, contextgeneral) {
    var alertWrongPasswordDialog = AlertDialog(
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.23,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: AppLoginRegisterPasswordIconsConstant
                    .loginPasswordFalseicon.toImg,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: BodyMediumBlackBoldText(
                  text: "E-mail Adresi veya Şifre Hatalı",
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: LabelMediumGreyText(
                    text: "Bilgileriniz yanlış, Lütfen tekrar deneyiniz.",
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (context) => alertWrongPasswordDialog);
  }

  void tooManyRequest(context, contextgeneral) {
    var alertTooManyRequestDialog = AlertDialog(
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.23,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: AppLoginRegisterPasswordIconsConstant
                      .loginUserBannedicon.toImg),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: BodyMediumBlackBoldText(
                  text: "Çok fazla hatalı giriş",
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: LabelMediumGreyText(
                  text:
                      "Çok fazla hatalı giriş yaptınız, hesabınız askıya alındı, şifrenizi sıfırlayabilir veya bi süre sonra tekrar deneyebilirsiniz.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (context) => alertTooManyRequestDialog);
  }

  void requiresrecentlogin(context, contextgeneral) {
    var alertrequiresrecentloginDialog = AlertDialog(
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.23,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: AppLoginRegisterPasswordIconsConstant
                      .registerEmailicon.toImg),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: BodyMediumBlackBoldText(
                  text: "E-mail Adresinizi Doğrulayınız",
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: LabelMediumGreyText(
                    text:
                        "Email adresinizi doğrulamadınız,lütfen gönderilen maili onaylayarak giriş yapabilirsiniz.",
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (context) => alertrequiresrecentloginDialog);
  }
}
