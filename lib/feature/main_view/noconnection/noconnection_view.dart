import 'package:flutter/material.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/enums/noconnection_enums.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class NoConnectionErrorView extends StatefulWidget {
  const NoConnectionErrorView({super.key});

  @override
  State<NoConnectionErrorView> createState() => _NoConnectionErrorViewState();
}

class _NoConnectionErrorViewState extends State<NoConnectionErrorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // img wiget
            buildimgWidget,
            // title wiget,
            builTitleWiget,
            // description widget
            builDescriptionWidget,
            // reload button
            buildReloadButtonWidget(context),
          ],
        ),
      ),
    );
  }

  // img widget
  Widget get buildimgWidget => Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        child: AppMainImgConstant.appNoConnectionErrorImg.toImg,
      );

  // title wiget,
  Widget get builTitleWiget => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BodyMediumBlackBoldText(
          text: NoConnectionErrorStrings.titleText.value,
          textAlign: TextAlign.center,
        ),
      );

  // description widget
  Widget get builDescriptionWidget => Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: LabelMediumBlackText(
          text: NoConnectionErrorStrings.subTitleText.value,
          textAlign: TextAlign.center,
        ),
      );

  // reload button
  Widget buildReloadButtonWidget(context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: LabelMediumMainColorText(
          text: NoConnectionErrorStrings.btnText.value,
          textAlign: TextAlign.center,
        ),
      );
}
