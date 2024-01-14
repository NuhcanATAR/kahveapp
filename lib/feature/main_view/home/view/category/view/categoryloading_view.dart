import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryLoadingView extends StatelessWidget {
  const CategoryLoadingView(
      {required this.title, required this.subTitle, super.key});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // img
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: LoadingAnimationWidget.hexagonDots(
              color: ColorBackgroundConstant.greenDarker,
              size: 35,
            ),
          ),
          // title
          Padding(
              padding: const EdgeInsets.all(10),
              child: BodyMediumBlackBoldText(
                textAlign: TextAlign.center,
                text: title,
              )),
          // description
          Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: LabelMediumBlackText(
                textAlign: TextAlign.center,
                text: subTitle,
              )),
        ],
      ),
    );
  }
}
