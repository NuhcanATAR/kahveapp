import 'package:flutter/material.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

mixin passwordMixin {
  void emailFalseAlert(contextgeneral, context) {
    var alertEmailFalseDialog = AlertDialog(
      title: SizedBox(
        height: 75,
        child:
            AppLoginRegisterPasswordIconsConstant.registerSendEmailicon.toImg,
      ),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.11,
        child: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BodyMediumBlackBoldText(
                  textAlign: TextAlign.center,
                  text: "Yenileme Bağlantısı Gönderildi"),
              SizedBox(
                height: 10,
              ),
              LabelMediumGreyText(
                textAlign: TextAlign.center,
                text:
                    "Email adresinize şifrenizi yenilemeniz için bağlantı gönderildi, kontrol ediniz.",
              ),
            ],
          ),
        ),
      ),
    );
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) => alertEmailFalseDialog,
    );
  }
}
