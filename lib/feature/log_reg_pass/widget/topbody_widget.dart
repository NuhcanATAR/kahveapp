import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:animate_do/animate_do.dart';

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
    return FadeInDown(
      child: Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          width: maxWidth,
          height: dynamicHeight(0.5),
          child: Container(
            padding: const EdgeInsets.only(
                left: 120, right: 120, bottom: 140, top: 140),
            decoration: BoxDecoration(
              color: ColorBackgroundConstant.greenDarker,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                image: DecorationImage(
                  image: AssetImage(ImgLogoConstants.appLogo.toPng),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
