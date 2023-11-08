import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kahve/product/widget/text_widget/title_medium_text.dart';
import 'package:kartal/kartal.dart';

class TopBodyWidget extends StatelessWidget {
  const TopBodyWidget({
    super.key,
    required this.maxWidth,
    required this.dynamicHeight,
  });
  final dynamic maxWidth;
  final dynamic dynamicHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: FadeInDown(
        child: SizedBox(
          width: maxWidth,
          height: dynamicHeight(0.5),
          child: Container(
            padding: context.padding.normal,
            decoration: BoxDecoration(
              color: ColorBackgroundConstant.greenDarker,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: buildTitleSubTitleWidget,
          ),
        ),
      ),
    );
  }

  // title & sub title
  Widget get buildTitleSubTitleWidget => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: maxWidth,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 10),
              child: TitleMediumWhiteBoldText(
                text: "Kahve Uygulamasına Hoşgeldiniz.",
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(
            width: maxWidth,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: LabelMediumWhiteText(
                text:
                    "Kahve Dünyasına giriş yaparak size en uygun kahveyi \nsipariş verin.",
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      );
}
