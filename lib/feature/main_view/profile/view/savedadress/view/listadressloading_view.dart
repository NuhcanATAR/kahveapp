import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListAdressLoadingView extends StatefulWidget {
  const ListAdressLoadingView({super.key});

  @override
  State<ListAdressLoadingView> createState() => _ListAdressLoadingViewState();
}

class _ListAdressLoadingViewState extends State<ListAdressLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // loading
            buildLoadingWidget,
            // title
            buildTitleWidget,
          ],
        ),
      ),
    );
  }

  // loading
  Widget get buildLoadingWidget => LoadingAnimationWidget.hexagonDots(
        color: ColorBackgroundConstant.greenDarker,
        size: 45,
      );

  // title
  Widget get buildTitleWidget => const Padding(
        padding: EdgeInsets.all(20),
        child: LabelMediumGreyText(
          text: "Lütfen Bekleyiniz...",
          textAlign: TextAlign.center,
        ),
      );
}
