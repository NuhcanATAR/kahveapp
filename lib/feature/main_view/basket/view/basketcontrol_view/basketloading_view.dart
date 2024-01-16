import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BasketLoadingView extends StatelessWidget {
  const BasketLoadingView({
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
          LoadingAnimationWidget.hexagonDots(
            color: ColorBackgroundConstant.greenDarker,
            size: 45,
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
