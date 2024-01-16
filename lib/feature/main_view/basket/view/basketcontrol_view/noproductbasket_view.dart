import 'package:flutter/material.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class NoProductBasketView extends StatelessWidget {
  const NoProductBasketView({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // loading
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
            child: AppErrorImgConstant.appErrorImg.toImg,
          ),
          // title
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: LabelMediumBlackBoldText(
              text: title,
              textAlign: TextAlign.center,
            ),
          ),
          // description
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: LabelMediumGreyText(
              text: description,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
