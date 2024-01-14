import 'package:flutter/material.dart';
import 'package:kahve/product/enums/home_enums.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
        top: 15,
      ),
      child: BodyMediumBlackBoldText(
        text: HomeStrings.welcomeTitleText.value,
        textAlign: TextAlign.left,
      ),
    );
  }
}
