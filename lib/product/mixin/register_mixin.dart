import 'package:flutter/material.dart';

import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

mixin RegisterMixin {
  void emailAlert(contextgeneral, context) {
    var alertEmailAlreadyInUserDialog = AlertDialog(
      title: SizedBox(
        height: 75,
        child: AppRegisterIconConstant.registerEmailicon.toImg,
      ),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.11,
        child: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BodyMediumBlackBoldText(
                  textAlign: TextAlign.center, text: "Email Kayıtlı!"),
              SizedBox(
                height: 10,
              ),
              LabelMediumGreyText(
                textAlign: TextAlign.center,
                text:
                    "Email adresine daha önceden kayıtlı bulunmakta, lütfen başka bir email adresi giriniz.",
              ),
            ],
          ),
        ),
      ),
    );
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) => alertEmailAlreadyInUserDialog,
    );
  }
}
