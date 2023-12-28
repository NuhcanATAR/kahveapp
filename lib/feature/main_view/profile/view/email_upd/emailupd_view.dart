import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/constants/string_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class EmailUpdView extends StatefulWidget {
  const EmailUpdView({super.key});

  @override
  State<EmailUpdView> createState() => _EmailUpdViewState();
}

class _EmailUpdViewState extends State<EmailUpdView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorBackgroundConstant.greenDarker,
            size: 20,
          ),
        ),
        title: const LabelMediumMainColorText(
            textAlign: TextAlign.center, text: "Email Güncelle"),
      ),
      body: Padding(
        padding: context.padding.normal,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // image
              buildimgWidget,
              // title
              buildTitleWidget,
              // description
              buildDescriptionWidget,
            ],
          ),
        ),
      ),
    );
  }

  // image
  Widget get buildimgWidget => FadeInUp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: AppProfileViewImagesConstant.emailUpdimg.toImg,
        ),
      );

  // title
  Widget get buildTitleWidget => FadeInUp(
        child: const Padding(
          padding: EdgeInsets.all(5),
          child: BodyMediumBlackBoldText(
              textAlign: TextAlign.center,
              text: AppProfileViewTextConstants.emailUpdTitle),
        ),
      );

  // description
  Widget get buildDescriptionWidget => FadeInUp(
        child: const LabelMediumGreyText(
          textAlign: TextAlign.center,
          text: AppProfileViewTextConstants.emailUpdSubTitle,
        ),
      );
}
